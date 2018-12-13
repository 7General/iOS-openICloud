//
//  VideoControlView.h
//  PIPVideo
//
//  Created by zzg on 2018/12/12.
//  Copyright © 2018年 zzg. All rights reserved.
//

/* 底部操作台 */
#import <UIKit/UIKit.h>
#import "VideoSliderView.h"


#define kVideoControlHeight 55
#define kVideoSlideHeight 6.0

@interface VideoControlView : UIView

@property (nonatomic, assign) NSTimeInterval  currentTime;
@property (nonatomic, assign) NSTimeInterval  duration;

@property (nonatomic, strong) VideoSliderView * slideView;
@property (nonatomic, strong) UILabel * currentTimeLabel;

@property (nonatomic, strong) UIButton * playButton;
@property (nonatomic, strong) UIButton * forwardButton;
@property (nonatomic, strong) UIProgressView * progress; //缓冲

@end
