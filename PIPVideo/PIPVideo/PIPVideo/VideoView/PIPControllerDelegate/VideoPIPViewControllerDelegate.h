//
//  VideoPIPViewControllerDelegate.h
//  PIPVideo
//
//  Created by zzg on 2018/12/15.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>
#import "VideoView.h"

@interface VideoPIPViewControllerDelegate : NSObject<AVPictureInPictureControllerDelegate>

@property (nonatomic, strong) VideoView * view;



@end
