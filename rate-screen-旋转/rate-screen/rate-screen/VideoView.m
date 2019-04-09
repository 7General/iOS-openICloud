//
//  VideoView.m
//  rate-screen
//
//  Created by zzg on 2019/3/24.
//  Copyright © 2019 zzg. All rights reserved.
//

#import "VideoView.h"
#import <AVFoundation/AVFoundation.h>


@interface VideoView()

@property (nonatomic, strong) AVPlayer                     *player;
@property (nonatomic, strong) AVPlayerItem                 *playerItem;
@property (nonatomic, strong) AVPlayerLayer                *playerLayer;

@end

@implementation VideoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initPlayer];
    }
    return self;
}

- (void)initPlayer {
    self.player = [[AVPlayer alloc] init];
    
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;  // 适配视频尺寸
    self.playerLayer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor blackColor]);
    [self.layer addSublayer:self.playerLayer];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"mp4"];
    
    NSURL *sourceMovieUrl = [NSURL fileURLWithPath:path];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieUrl options:nil];
    self.playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    
    
     [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    
    [self.player play];
}

-(void)layoutSubviews {
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationPortrait == orientation) {
        self.playerLayer.frame = CGRectMake(0, 0, width, height);
    }
    else {
        self.playerLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    
    
    NSLog(@"-------");
}

@end
