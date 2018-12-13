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
        self.slider.minimumTrackTintColor = [UIColor colorWithRed:76 / 255.0 green:130/255.0 blue:243/255.0 alpha:1];
        self.slider.maximumValue = 1;
        
        [self.slider addTarget:self action:@selector(beginDragging) forControlEvents:UIControlEventTouchDown];
        [self.slider addTarget:self action:@selector(dragging) forControlEvents:UIControlEventValueChanged];
        [self.slider addTarget:self action:@selector(endDragging) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        
        [self addSubview:self.slider];
    }
    return self;
}



-(void)layoutSubviews {
    self.frame = self.bounds;
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
