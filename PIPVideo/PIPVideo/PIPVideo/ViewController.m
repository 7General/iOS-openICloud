//
//  ViewController.m
//  PIPVideo
//
//  Created by zzg on 2018/12/12.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "ViewController.h"
/* 引入两个框架 */
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVPlayerViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    NSString * path = [[NSBundle mainBundle]pathForResource:@"282" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AVPlayerViewController * play = [[AVPlayerViewController alloc]init];
    play.delegate = self;
    play.player = [[AVPlayer alloc]initWithURL:url];
    [self presentViewController:play animated:YES completion:nil];
}

- (BOOL)playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart:(AVPlayerViewController *)playerViewController {
    return YES;
}

- (void)playerViewController:(AVPlayerViewController *)playerViewController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL))completionHandler {
    // 在这里，做一些恢复视图的处理，将之前进入PIP，被dismiss掉的playerViewController重新present
     [self presentViewController:playerViewController animated:YES completion:^{
        completionHandler(YES);
    }];
}




@end
