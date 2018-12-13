//
//  VideoSliderView.h
//  PIPVideo
//
//  Created by zzg on 2018/12/12.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <UIKit/UIKit.h>


@class VideoSliderView;

@protocol  VideoSliderViewDelegate<NSObject>

@optional

- (void)videoSlideViewDidTap:(VideoSliderView *)slideView;

/**
 开始

 @param slideView VideoSliderView
 */
- (void)videoSlideViewDidBeginDragging:(VideoSliderView *)slideView;

/**
 正在

 @param slideView VideoSliderView
 */
- (void)videoSlideViewDidDragging:(VideoSliderView *)slideView;

/**
 结束

 @param slideView VideoSliderView
 */
- (void)videoSlideViewDidEndDragging:(VideoSliderView *)slideView;

@end

@interface VideoSliderView : UIView

/* slider对象 */
@property (nonatomic, strong) UISlider * slider;

@property (nonatomic, assign) CGFloat  value;

@property (nonatomic, weak) id<VideoSliderViewDelegate> delegate;


- (void)setMaximumTrackImage:(UIImage *)image forState:(UIControlState)state;

@end
