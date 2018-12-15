//
//  VideoTaphandler.h
//  PIPVideo
//
//  Created by zzg on 2018/12/15.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VideoView;

@interface VideoTaphandler : NSObject

@property (nonatomic, readonly) VideoView * view;

- (instancetype)initTapHandlerWithView:(VideoView *)view;

- (void)invalidate;
@end
