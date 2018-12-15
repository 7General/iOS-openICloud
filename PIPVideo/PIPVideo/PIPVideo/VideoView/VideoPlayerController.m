//
//  VideoPlayerContrller.m
//  PIPVideo
//
//  Created by zzg on 2018/12/12.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "VideoPlayerController.h"
#import "VideoView.h"

@interface VideoPlayerController ()<VideoViewDelegate>

@property (nonatomic, strong) VideoView *zView;

@end

@implementation VideoPlayerController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zView = [[VideoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_zView];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"282" ofType:@"mp4"];
    [self.zView setPath:path];
    [self.zView setTitle:@"视频播放"];
    self.zView.VideoBackgroundColor = [UIColor blackColor];
    self.zView.supportPictureInpicture = YES;  // 支持画中画,则不支持后台暂停，反之。。。
    
    [self.zView play];
    
    self.zView.delegate = self;
    
}

- (void)pictureInPictureControllerDidStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    NSLog(@"开始");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pictureInPictureController:(AVPictureInPictureController *)pictureInPictureController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL))completionHandler {
    NSLog(@"还原");
    [_vc presentViewController:self animated:YES completion:nil];
    [_zView play];
    completionHandler(YES);
}

- (void)dealloc
{
    _zView.delegate = nil;
    _zView = nil;
}


@end
