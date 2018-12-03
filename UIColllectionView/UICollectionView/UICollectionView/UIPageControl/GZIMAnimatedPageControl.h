//
//  LCAnimatedPageControl.h
//  LCAnimatedPageControl
//
//  Created by beike on 6/17/15.
//  Copyright (c) 2015 beike. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GZIMAnimatedPageControl : UIControl


@property (nonatomic, strong) UIScrollView *sourceScrollView;

@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, assign) NSInteger currentOfPage;

@property (nonatomic, assign) CGFloat indicatorDiameter;
@property (nonatomic, assign) CGFloat indicatorMultiple;
@property (nonatomic, assign) CGFloat indicatorMargin;

- (void)prepareShow;
- (void)clearIndicators;


@end
