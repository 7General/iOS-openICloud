//
//  CustomPageControl.m
//  UICollectionView
//
//  Created by zzg on 2018/11/30.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "CustomPageControl.h"
//#import "GZIMPageControl.h"
#import "UIView+GZCSAddition.h"
#import "GZIMAnimatedPageControl.h"

@interface CustomPageControl()
//@property (nonatomic, strong) GZIMPageControl * cusPageController;
@property (nonatomic, strong) GZIMAnimatedPageControl * cusPageController;
@end

@implementation CustomPageControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI {
    
    [self addSubview:self.cusPageController];
    
}

-(GZIMAnimatedPageControl *)cusPageController {
    if (!_cusPageController) {
        _cusPageController = [[GZIMAnimatedPageControl alloc] initWithFrame:self.frame];
        _cusPageController.numberOfPages = 5;
    
        
        [_cusPageController prepareShow];
        _cusPageController.backgroundColor = [UIColor grayColor];
        [_cusPageController addTarget:self action:@selector(s_pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _cusPageController;
}



- (void) s_pageControlChanged:(UIPageControl *)pageControl {

}

-(void)setCurrentPage:(NSInteger)currentPage {
    NSLog(@"1--->>setCurrentPage:%ld",currentPage);
    _currentPage = currentPage;

}
- (void)setPageNumbers:(NSInteger)pageNumbers {
    NSLog(@"2：--->>.setPageNumbers:%ld",pageNumbers);
    _pageNumbers = pageNumbers;
    self.cusPageController.numberOfPages = pageNumbers;
}

@end
