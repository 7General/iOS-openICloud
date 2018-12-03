//
//  LLPageControl.m
//  RongXiangYD
//
//  Created by 嘚嘚以嘚嘚 on 2018/7/2.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "GZIMPageControl.h"

@implementation GZIMPageControl

-(id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    return self;
    
}
- (void)setCurrentImage:(UIImage *)currentImage {
    if (currentImage) {
        _currentImage = currentImage;
    }
}
- (void)setOtherImage:(UIImage *)otherImage {
    if (otherImage) {
        _otherImage = otherImage;
    }
}
-(void) updateDots {
    
    
    for (int i=0; i<[self.subviews count]; i++) {
        //圆点
        UIView* dot = [self.subviews objectAtIndex:i];
        //添加imageView
        if ([dot.subviews count] == 0) {
            UIImageView * view = [[UIImageView alloc]initWithFrame:dot.bounds];
            [dot addSubview:view];
        };
        
        //配置imageView
        UIImageView * view = dot.subviews[0];
        
        if (i==self.currentPage) {
            if (self.currentImage) {
                view.image=self.currentImage;
                dot.backgroundColor = [UIColor clearColor];
            }
            
        }else {
            
            if (self.otherImage) {
                view.image=self.otherImage;
                dot.backgroundColor = [UIColor clearColor];
            }
        }
    }
    
    
    
}

-(void)setCurrentPage:(NSInteger)page
{
    
    [super setCurrentPage:page];
    
    [self updateDots];
    
}

@end
