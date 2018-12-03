//
//  LCAnimatedPageControl.m
//  LCAnimatedPageControl
//
//  Created by beike on 6/17/15.
//  Copyright (c) 2015 beike. All rights reserved.
//

#import "GZIMAnimatedPageControl.h"
#import "UIView+GZCSAddition.h"


static CGFloat kLCDoubleNumber = 2.0f;
static CGFloat kLCHalfNumber = 0.5f;
static CGFloat kLCMultiple = 1.4f;

@interface GZIMAnimatedPageControl ()<UIScrollViewDelegate>

/* 存放小点view数据源 */
@property (nonatomic, strong) NSMutableArray *indicatorViewDatasource;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *squirmView;

@property (nonatomic, assign) CGFloat radius;

@end

@implementation GZIMAnimatedPageControl

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _contentView.backgroundColor = [UIColor grayColor];
    [self addSubview:_contentView];
    
    self.indicatorViewDatasource = [NSMutableArray array];
    _numberOfPages = 0;
    _currentPage = 0;
    
    _indicatorMultiple = kLCMultiple;
    _indicatorDiameter = self.frame.size.height / _indicatorMultiple;
    _indicatorMargin = 0.0f;
}

- (void)prepareShow{
    [self addIndicatorsWithIndex:0];
    
    
    self.squirmView = [[UIView alloc] init];
    self.squirmView.clipsToBounds = YES;
    self.squirmView.layer.cornerRadius = 6;
    self.squirmView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.squirmView];
    
    [self layoutSquirmView];
}

- (void)layoutSquirmView {
    [self.contentView bringSubviewToFront:self.squirmView];
    self.squirmView.hidden = !_numberOfPages;

    self.squirmView.width = self.indicatorDiameter;
    self.squirmView.height = self.indicatorDiameter;
    self.squirmView.centerY = self.contentView.centerY;
    self.squirmView.centerX = (_indicatorDiameter * _indicatorMultiple * kLCHalfNumber);
    
    self.squirmView.backgroundColor = [UIColor redColor];
    
    
    [self.sourceScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}




- (void)clearIndicators{
    
}


- (void)addIndicatorsWithIndex:(NSInteger)index{
    for (NSInteger number = index; number < _numberOfPages; number ++ ) {
        UIView *indicator = [[UIView alloc] init];
        indicator.clipsToBounds = YES;
        indicator.layer.cornerRadius = _radius;
        [self.indicatorViewDatasource addObject:indicator];
    }
    [self layoutContentView];
}
- (void)layoutContentView {
    [self.indicatorViewDatasource enumerateObjectsUsingBlock:^(UIView * view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.width = self.indicatorDiameter;
        view.height = self.indicatorDiameter;
        
        view.centerY = self.contentView.centerY;
        view.centerX = (_indicatorDiameter * _indicatorMultiple * kLCHalfNumber) + idx * (_indicatorDiameter * _indicatorMultiple + _indicatorMargin);
        view.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:view];
    }];
}



- (void)setCurrentPage:(NSInteger)currentPage{
    [self setCurrentPage:currentPage sendEvent:NO];
}

- (void)setCurrentPage:(NSInteger)currentPage sendEvent:(BOOL)sendEvent{
    _currentPage = MIN(currentPage, _numberOfPages - 1);
    if (sendEvent) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)setNumberOfPages:(NSInteger)numberOfPages{
    _numberOfPages = numberOfPages;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    NSValue *oldOffsetValue = change[NSKeyValueChangeOldKey];
    CGPoint oldOffset = [oldOffsetValue CGPointValue];
    
    NSValue *newOffsetValue = change[NSKeyValueChangeNewKey];
    CGPoint newOffset = [newOffsetValue CGPointValue];
    
    CGFloat scrollViewWidth = [(UIScrollView *)object bounds].size.width;
    
    CGFloat rate = newOffset.x / scrollViewWidth;
    
    if (rate >= 0.0f && rate <= _numberOfPages - 1) {
        
        NSInteger currentIndex = (NSInteger)ceilf(rate);
        NSInteger lastIndex = (NSInteger)floorf(rate);
        if (currentIndex == lastIndex && currentIndex >= 1) {
            lastIndex -= 1;
        }
    
        CGFloat timeOffset = rate - floorf(rate);
        if (timeOffset == 0.0f && currentIndex) {
            timeOffset = 1.0f;
        }
        
        if (timeOffset - kLCHalfNumber <= 0.0f) {
            timeOffset = timeOffset * kLCDoubleNumber;
        } else {
            timeOffset = (CGFloat)ABS(timeOffset - 1.0f) * kLCDoubleNumber;
        }
        
        CGFloat number = (_indicatorMargin - _indicatorDiameter) * kLCHalfNumber;
        self.squirmView.centerX = (_indicatorDiameter * _indicatorMultiple * kLCHalfNumber) + rate * (_indicatorDiameter * _indicatorMultiple + _indicatorMargin);

//        self.squirmView.width =  self.squirmView.width + timeOffset;// * (_indicatorDiameter + _indicatorMargin);
        
        
        self.currentPage = currentIndex;
    }
}


- (void)dealloc{
    [self.sourceScrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
