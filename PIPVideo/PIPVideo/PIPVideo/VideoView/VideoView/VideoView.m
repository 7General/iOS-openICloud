//
//  VideoView.m
//  PIPVideo
//
//  Created by zzg on 2018/12/12.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "VideoView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "VideoPIPViewControllerDelegate.h"
#import "VideoTaphandler.h"


#define kIsPlayLocalVideo 1

@interface VideoView()<VideoSliderViewDelegate,AVPictureInPictureControllerDelegate>

@property (nonatomic, strong) AVPlayer                     *player;            // 播放属性
@property (nonatomic, strong) AVPlayerItem                 *playerItem;
@property (nonatomic, strong) AVPlayerLayer                *playerLayer;
@property (nonatomic, assign) CGFloat                      width;              // 坐标
@property (nonatomic, assign) CGFloat                      height;             // 坐标
@property (nonatomic, strong) VideoTaphandler             *tapHandler;        // 轻拍手势
//@property (nonatomic, strong) ZVideoPanHandler             *panHandler;        // 滑动手势
@property (nonatomic, assign) BOOL                         isPlayingBeforeDrag;// 滑动前是否是播放状态
@property (nonatomic, strong) NSTimer                      *timer;// 进度计时器、播放中自动隐藏控制台计数
@property (nonatomic, strong) NSTimer                      *hiddenTimer; // 暂停后自动隐藏控制台的计时器
@property (nonatomic, strong) UISlider                     *volumeSlider;     // 获取系统音量
@property (nonatomic, strong) AVPictureInPictureController *pipViewController;// 画中画
@property (nonatomic, strong) VideoPIPViewControllerDelegate *pipDelegate;
@end

@implementation VideoView

static int controlViewHideTime = 0;// timer运行中的计数，== 7执行隐藏
static int autoHiddenCount     = 0;// timer停止（player暂停），hiddenTimer开始，== 7 执行隐藏


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.width = self.frame.size.width;
        self.height = self.frame.size.height;
        
        AVAudioSession * audioSession = [AVAudioSession sharedInstance];
        NSError * error = nil;
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:&error];
        if (error) {
            NSLog(@"--error:%@",[error description]);
        }
        [self initPlayer];
        [self initControlView];
        [self initNaviBackView];
        [self initGesture];
        [self initTimer];
//        [self initNotification];

    }
    return self;
}
- (void)initGesture {
    self.tapHandler = [[VideoTaphandler alloc] initTapHandlerWithView:self];
}


/**
 创建player
 */
- (void)initPlayer {
    _currentVolume = 0;
    self.player = [[AVPlayer alloc] init];
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = CGRectMake(0, 0, self.width, self.height);
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    self.playerLayer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor blackColor]);
    
    [self.layer addSublayer:self.playerLayer];
}

/**
 初始化底部控制台
 */
- (void)initControlView {
    CGFloat y = CGRectGetMaxY(self.frame) - kVideoControlHeight;
    self.controlView = [[VideoControlView alloc] initWithFrame:CGRectMake(0, y, self.frame.size.width, kVideoControlHeight)];
    [self.controlView.playButton addTarget:self action:@selector(playOrPause) forControlEvents:UIControlEventTouchUpInside];
    [self.controlView.playButton setBackgroundImage:[UIImage imageNamed:@"pauseBtn"] forState:UIControlStateNormal];
    self.controlView.playButton.selected = NO;
    
    [self.controlView.forwardButton addTarget:self action:@selector(unKownAction) forControlEvents:UIControlEventTouchUpInside];
    self.controlView.slideView.delegate = self;
    [self addSubview:self.controlView];
}

/**
 初始化顶部导航栏
 */
- (void)initNaviBackView {
    _naviBack = [[VideoNaviView alloc] initWithFrame:
                 CGRectMake(0, 0, self.frame.size.width, kVideoNaviHeight)];
    
    [_naviBack.backButton addTarget:self
                             action:@selector(didCloseVideoView:)
                   forControlEvents:UIControlEventTouchUpInside];
    
    // 画中画开关
    [_naviBack.pipButton addTarget:self
                            action:@selector(didOpenPipMode)
                  forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_naviBack];
}

/**
 初始化通知
 */
- (void)initNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)applicationWillResignActive {
    [self.pipViewController startPictureInPicture];
}

#pragma mark 返回按钮
- (void)didCloseVideoView:(UIButton *)sender {
    if (self.delegate && [self.description respondsToSelector:@selector(videoView:didCloseAtTime:)]) {
        [self.delegate videoView:self didCloseAtTime:0];
        [self stop];
    }
}

#pragma mark 开启画中画
- (void)didOpenPipMode {
    [self.pipViewController startPictureInPicture];
}


#pragma mark 播放下一曲
- (void)unKownAction {
    
}

#pragma mark 播放或者暂停
- (void)playOrPause {
    if (self.controlView.playButton.selected) {
        [self play];
    } else {
        [self pause];
    }
}

#pragma mark 播放
- (void)play {
    controlViewHideTime = 0;
    autoHiddenCount = 0;
    [self.controlView.playButton setBackgroundImage:[UIImage imageNamed:@"pauseBtn"] forState:UIControlStateNormal];
    self.controlView.playButton.selected = !self.controlView.playButton.selected;
    if (![_timer isValid]) {
        [self initTimer];
    }
    [_timer fire];
    [self.player play];
    [_hiddenTimer invalidate];
}

#pragma mark 创建计时器
- (void)initTimer {
    //计时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                              target:self
                                            selector:@selector(timeRun)
                                            userInfo:nil
                                             repeats:YES];
}

#pragma mark 响应timer
- (void)timeRun {
    controlViewHideTime++;
    NSLog(@"播放中自动隐藏计数：%d", controlViewHideTime);
    if (_playerItem.duration.timescale != 0) {
        CMTime currentTime = self.player.currentTime;
        CMTime duration    = self.playerItem.duration;
        _controlView.currentTime     = CMTimeGetSeconds(currentTime);
        _controlView.duration        = duration.value / duration.timescale;
        _controlView.slideView.value = _controlView.currentTime / _controlView.duration;//当前进度
    }
    if (_player.status == AVPlayerStatusReadyToPlay) {
        // 等待加载中
    } else {
        
    }
    if (controlViewHideTime == 7) {
        controlViewHideTime = 0;
        [self hiddenActionView];
    }
}

#pragma mark 隐藏控制台
- (void)hiddenActionView {
    [UIView animateWithDuration:0.5 animations:^{
        _controlView.alpha = 0;
        _naviBack.alpha = 0;
    }];
}

#pragma mark 响应轻拍事件
- (void)showActionView {
    controlViewHideTime = 0;
    autoHiddenCount = 0;
    if (_controlView.alpha == 1) {
        [UIView animateWithDuration:0.5 animations:^{
            _controlView.alpha = 0;
            _naviBack.alpha = 0;
        }];
    } else if (_controlView.alpha == 0){
        [UIView animateWithDuration:0.5 animations:^{
            _controlView.alpha = 1;
            _naviBack.alpha = 1;
        }];
    }
}

- (void)pause {
    controlViewHideTime = 0;
    autoHiddenCount = 0;
    [self.controlView.playButton setBackgroundImage:[UIImage imageNamed:@"playBtn"]
                                       forState:UIControlStateNormal];
    self.controlView.playButton.selected =!_controlView.playButton.selected;
    
    [self.timer invalidate];

    [self.player pause];
    // 暂停后需自动隐藏控制台
//    [self autoHiddenActionView];
}

- (void)stop {
    [self.timer invalidate];
    [self.hiddenTimer invalidate];
    [self.player replaceCurrentItemWithPlayerItem:nil];
}


#pragma mark 设置路径
- (void)setPath:(NSString *)path {
#if kIsPlayLocalVideo
    NSURL *sourceMovieUrl = [NSURL fileURLWithPath:path];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieUrl options:nil];
    self.playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
#else
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:path]];
#endif
    [self.playerItem addObserver:self
                      forKeyPath:@"loadedTimeRanges"
                         options:NSKeyValueObservingOptionNew context:nil];
    [self.player replaceCurrentItemWithPlayerItem:_playerItem];
}


#pragma mark 布局
- (void)layoutSubviews {
    _width = self.frame.size.width;
    _height = self.frame.size.height;
    CGFloat y;
    self.backgroundColor = [UIColor blackColor];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationPortrait == orientation) {
        
        y = _width * _width / _height - kVideoControlHeight;
        
        //    self.frame = CGRectMake(0, 0, _width, _width * _width / _height);
        _playerLayer.frame = CGRectMake(0, 0, _width, _width * _width / _height);
    }
    else {
        
        y = CGRectGetMaxY(self.frame) - kVideoControlHeight;
        
        //    self.frame = CGRectMake(0, 0, _width, _height);
        _playerLayer.frame = CGRectMake(0, 0, _width, _height);
        
    }
    _controlView.frame = CGRectMake(0, y, self.frame.size.width, kVideoControlHeight);
    _naviBack.frame    = CGRectMake(0, 0, self.frame.size.width, kVideoNaviHeight);
}

#pragma mark 设置标题
-(void)setTitle:(NSString *)title {
    self.naviBack.title = title;
}
#pragma mark 设置背景色
-(void)setVideoBackgroundColor:(UIColor *)VideoBackgroundColor {
    self.backgroundColor = VideoBackgroundColor;
}

#pragma mark 设置是否支持画中画
- (void)setSupportPictureInpicture:(BOOL)supportPictureInpicture {
    if (supportPictureInpicture) {
        [self initPicInPicViewController];
        self.naviBack.pipButton.enabled = YES;
        // 取消后台暂停通知
//        [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                        name:UIApplicationDidEnterBackgroundNotification
//                                                      object:nil];
    } else {
        self.naviBack.pipButton.enabled = NO;
    }
}

- (void)initPicInPicViewController {
    self.pipViewController = [[AVPictureInPictureController alloc] initWithPlayerLayer:self.playerLayer];
    self.pipDelegate = [[VideoPIPViewControllerDelegate alloc] init];
    self.pipViewController.delegate = self.pipDelegate;
    self.pipDelegate.view = self;
    [self.pipViewController startPictureInPicture];
}


#pragma mark 计算缓冲进度
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        CMTime duration = self.playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [self.controlView.progress setProgress:timeInterval / totalDuration animated:NO];
    }
}

- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}


-(void)dealloc {
    [_timer invalidate];
    [_hiddenTimer invalidate];
}




@end
