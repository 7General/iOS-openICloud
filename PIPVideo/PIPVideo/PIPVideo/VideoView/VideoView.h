//
//  VideoView.h
//  PIPVideo
//
//  Created by zzg on 2018/12/12.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

#import "VideoControlView.h"
#import "VideoNaviView.h"

#define kVideoNaviHeight 64

@interface VideoView : UIView



@property (nonatomic, strong  ) NSString           *path;                 // 资源路径

@property (nonatomic, strong  ) NSString           *title;                 // 视频标题

@property (nonatomic, strong  ) VideoControlView  *controlView;          // 控制台

@property (nonatomic, strong  ) VideoNaviView     *naviBack;             // 返回

@property (nonatomic, readonly) CGFloat            currentVolume;         // 当前音量

@property (nonatomic, readonly) CGFloat            currentTime;           // 当前播放时间

@property (nonatomic, strong  ) UIColor            *VideoBackgroundColor; // 视频背景色

@property (nonatomic, readonly) CGFloat            rate;                  // 1:playing 0:pause,用于在vc中判断，再次点击视频，不会重复打开

@property (nonatomic, getter = isSupportPictureInPicture) BOOL supportPictureInpicture;// 是否支持画中画,默认不支持

//@property (nonatomic, assign  ) id <VideoViewDelegate> delegate;

- (void)play;                          // 播放

- (void)pause;                         // 暂停

//- (void)stop;                          // 停止


- (void)showActionView;                // 显示控制台

- (void)playOrPause;                   // 开始/暂停(双击事件)


@end
