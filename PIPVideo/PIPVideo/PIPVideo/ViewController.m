//
//  ViewController.m
//  PIPVideo
//
//  Created by zzg on 2018/12/12.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "ViewController.h"
///* 引入两个框架 */
//#import <AVKit/AVKit.h>
//#import <AVFoundation/AVFoundation.h>

#import "VideoPlayerController.h"
#import "VideoSliderView.h"

@interface ViewController ()
//<AVPlayerViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIGraphicsBeginImageContextWithOptions((CGSize){1,1}, NO, 0.0f);
    UIImage * transparentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();


    UISlider * slider = [[UISlider alloc]initWithFrame:CGRectMake(10 , 100, 300, 50)];
    slider.minimumValue = 0.0;
    slider.maximumValue = 100.0;

    slider.value = 50;

    [slider setContinuous:YES];
    
    
//    slider.minimumTrackTintColor = [UIColor colorWithRed:76 / 255.0 green:130/255.0 blue:243/255.0 alpha:1];

    //05.滑块条最小值处设置的图片，默认为nil
//    slider.minimumValueImage = [UIImage imageNamed:@"nextPlayer"];

    //06.滑块条最大值处设置的图片，默认为nil
//    slider.maximumValueImage = [UIImage imageNamed:@"pauseBtn"];

    //07.minimumTrackTintColor : 小于滑块当前值滑块条的颜色，默认为蓝色
    slider.minimumTrackTintColor = [UIColor redColor];

    //08.maximumTrackTintColor: 大于滑块当前值滑块条的颜色，默认为白色
//    slider.maximumTrackTintColor = [UIColor blueColor];

    //09.thumbTintColor : 当前滑块的颜色，默认为白色
//    slider.thumbTintColor = [UIColor yellowColor];
//    [slider setThumbImage:[UIImage imageNamed:@"iconfont-yuan1"] forState:UIControlStateNormal];
//    [slider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];

    //    10.currentMaximumTrackImage : 滑块条最大值处设置的图片
    //    11.currentMinimumTrackImage : 滑块条最小值处设置的图片
    //    12.currentThumbImage: 当前滑块的图片
    [self.view addSubview:slider];
    
    
//    UIProgressView *progress = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 200, 300, 4)];
//    [self.view addSubview:progress];
    
    
    
//    VideoSliderView* slideView = [[VideoSliderView alloc] initWithFrame:CGRectMake(10, 300, 400, 6)];
//    slideView.value = 0.5;
//    [slideView setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
//    [self.view addSubview:slideView];
    
    self.view.backgroundColor = [UIColor grayColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    VideoPlayerController * video = [[VideoPlayerController alloc] init];
    [self presentViewController:video animated:YES completion:^{
        
    }];
//    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
//    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
//
//    NSString * path = [[NSBundle mainBundle]pathForResource:@"282" ofType:@"mp4"];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    AVPlayerViewController * play = [[AVPlayerViewController alloc]init];
//    play.delegate = self;
//    play.player = [[AVPlayer alloc]initWithURL:url];
//    [self presentViewController:play animated:YES completion:nil];
}

//- (BOOL)playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart:(AVPlayerViewController *)playerViewController {
//    return YES;
//}
//
//- (void)playerViewController:(AVPlayerViewController *)playerViewController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL))completionHandler {
//    // 在这里，做一些恢复视图的处理，将之前进入PIP，被dismiss掉的playerViewController重新present
//     [self presentViewController:playerViewController animated:YES completion:^{
//        completionHandler(YES);
//    }];
//}




@end
