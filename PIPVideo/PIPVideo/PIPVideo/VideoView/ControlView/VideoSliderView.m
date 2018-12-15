//
//  VideoSliderView.m
//  PIPVideo
//
//  Created by zzg on 2018/12/12.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "VideoSliderView.h"

@implementation VideoSliderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.slider = [[UISlider alloc] initWithFrame:self.bounds];
        [self.slider setThumbImage:[UIImage imageNamed:@"iconfont-yuan1"] forState:UIControlStateNormal];
        /* 小于滑块当前值滑块条的颜色，默认为蓝色 */
        self.slider.minimumTrackTintColor = [UIColor colorWithRed:76 / 255.0 green:130/255.0 blue:243/255.0 alpha:1];
        /* 大于滑块当前值得颜色，默认为白色 */
//        self.slider.maximumTrackTintColor = [UIColor redColor];
        /* 当值可以改变时，滑块可以滑动到最大位置的值，默认为1.0 */
        self.slider.maximumValue = 1;
        
        [self.slider addTarget:self action:@selector(beginDragging) forControlEvents:UIControlEventTouchDown];
        [self.slider addTarget:self action:@selector(dragging) forControlEvents:UIControlEventValueChanged];
        [self.slider addTarget:self action:@selector(endDragging) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        
        [self addSubview:self.slider];
    }
    return self;
}



-(void)layoutSubviews {
    self.slider.frame = self.bounds;
}

-(void)setValue:(CGFloat)value {
    self.slider.value = value;
}

-(CGFloat)value {
    return self.slider.value;
}

-(void)setMaximumTrackImage:(UIImage *)image forState:(UIControlState)state {
    [self.slider setMaximumTrackImage:image forState:state];
}


/**
 开始
 */
- (void)beginDragging {
    if ([_delegate respondsToSelector:@selector(videoSlideViewDidBeginDragging:)]) {
        [_delegate videoSlideViewDidBeginDragging:self];
    }
}

/**
 正在
 */
- (void)dragging {
    if ([_delegate respondsToSelector:@selector(videoSlideViewDidDragging:)]) {
        [_delegate videoSlideViewDidDragging:self];
    }
}

/**
 结束
 */
- (void)endDragging {
    if ([_delegate respondsToSelector:@selector(videoSlideViewDidEndDragging:)]) {
        [_delegate videoSlideViewDidEndDragging:self];
    }
}



@end
