//
//  VideoControlView.m
//  PIPVideo
//
//  Created by zzg on 2018/12/12.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "VideoControlView.h"
#import "VideoSliderView.h"
#import "ZVideoUtilities.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoControlView()

@end

@implementation VideoControlView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.122 alpha:0.5];
        [self initSlider];
        [self initButton];
        [self initCurrentTimeLabel];
    }
    return self;
}


/**
 进度条
 */
- (void)initSlider {
    CGFloat y = CGRectGetHeight(self.frame) - 28;
    // 缓冲区
    self.progress = [[UIProgressView alloc] initWithFrame:CGRectMake(102, y + 2, self.frame.size.width - 234, kVideoSlideHeight)];
    [self addSubview:self.progress];
    
    // 进度条
    self.slideView = [[VideoSliderView alloc] initWithFrame:CGRectMake(100, y, self.frame.size.width - 230, kVideoSlideHeight)];
    self.slideView.value = 0.0;
    
    [self customVideoSlider];
}
- (void)customVideoSlider {
    UIGraphicsBeginImageContextWithOptions((CGSize){1,1}, NO, 0.0f);
    UIImage * transparentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.slideView setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
}

#pragma mark 播放和下一首按钮
- (void)initButton {
    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playButton.frame = CGRectMake(15, CGRectGetHeight(self.frame) - 40, 30, 30);
    [self addSubview:self.playButton];
    
    self.forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forwardButton.frame = CGRectMake(60, CGRectGetHeight(self.frame) - 40, 25, 25);
    [self addSubview:self.forwardButton];
    [self.forwardButton setBackgroundImage:[UIImage imageNamed:@"nextPlayer"] forState:UIControlStateNormal];
}

#pragma mark 创建播放时间label
- (void)initCurrentTimeLabel {
    self.currentTimeLabel = [[UILabel alloc]initWithFrame:
                         CGRectMake(self.frame.size.width *0.88, CGRectGetHeight(self.frame) - 35.5, 150, 20)];
    [self addSubview:self.currentTimeLabel];
    self.currentTimeLabel.textColor = [UIColor whiteColor];
    self.currentTimeLabel.font = [UIFont systemFontOfSize:12];
    self.currentTimeLabel.text = @"00:00:00/00:00:00";
}

/* 设置总时间 */
-(void)setDuration:(NSTimeInterval)duration {
    _duration = duration;
    NSArray * ranges = [self getRangesWithString];
    _currentTimeLabel.text =
    [_currentTimeLabel.text stringByReplacingCharactersInRange:[ranges[1] rangeValue]
                                                    withString:TimeStringWithSeconds(_duration)];
    if (_duration > 0) {
        _slideView.value = _currentTime / _duration;
    }
    else {
        _slideView.value = 0;
    }
    
}
#pragma mark 设置当前时间
- (void)setCurrentTime:(NSTimeInterval)currentTime {
    _currentTime = currentTime;
    NSArray *ranges = [self getRangesWithString];
    
    _currentTimeLabel.text =
    [_currentTimeLabel.text stringByReplacingCharactersInRange:[ranges[0] rangeValue]
                                                    withString:TimeStringWithSeconds(_currentTime)];
    if (_duration) {
        _slideView.value = _currentTime / _duration;
    }
    else {
        _slideView.value = 0;
    }
}

- (NSArray *)getRangesWithString {
    NSArray *timeLabel = [_currentTimeLabel.text componentsSeparatedByString:@"/"];
    NSRange range1 = [_currentTimeLabel.text rangeOfString:timeLabel[0]];
    NSRange range2 = [_currentTimeLabel.text rangeOfString:timeLabel[1]];
    
    NSValue *value1 = [NSValue valueWithRange:range1];
    NSValue *value2 = [NSValue valueWithRange:range2];
    
    return @[value1, value2];
}

#pragma mark 布局
- (void)layoutSubviews
{
    CGFloat y = CGRectGetHeight(self.frame) - 28;
    _slideView.frame = CGRectMake(100, y, self.frame.size.width - 230, kVideoSlideHeight);
    _playButton.frame = CGRectMake(15, CGRectGetHeight(self.frame) - 40, 30, 30);
    _forwardButton.frame = CGRectMake(60, CGRectGetHeight(self.frame) - 38, 25, 25);
    _progress.frame = CGRectMake(102, y + 2, self.frame.size.width - 234, kVideoSlideHeight);
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationPortrait == orientation) {
        _currentTimeLabel.frame = CGRectMake(self.frame.size.width * 0.88 - 25, CGRectGetHeight(self.frame) - 35.5, 150, 20);
    }
    else {
        _currentTimeLabel.frame = CGRectMake(self.frame.size.width *0.88, CGRectGetHeight(self.frame) - 35.5, 150, 20);
    }
    [_slideView setNeedsLayout];
}


@end
