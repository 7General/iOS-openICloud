//
//  CollectionViewController.m
//  UICollectionView
//
//  Created by zzg on 2018/12/3.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "CollectionViewController.h"
#import "UIView+GZCSAddition.h"

@interface CollectionViewController ()<UIScrollViewDelegate>

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIScrollView * caroselScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
    caroselScrollView.contentSize = CGSizeMake(self.view.width * 5, 0);
    
    for (NSInteger index =0; index < 5; index++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(index * self.view.width, 0, self.view.width, 200)];
         UIColor * randomColor= [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        view.backgroundColor =  randomColor;
        [caroselScrollView addSubview:view];
    }
    caroselScrollView.scrollEnabled = YES;
    caroselScrollView.bounces = NSNotFound;
    caroselScrollView.showsHorizontalScrollIndicator = NO;
    caroselScrollView.delegate = self;
    caroselScrollView.pagingEnabled = YES;
    [self.view addSubview:caroselScrollView];
    
    self.pageController = [[GZIMAnimatedPageControl alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40)];
    self.pageController.layer.borderColor = [UIColor redColor].CGColor;
    self.pageController.layer.borderWidth = 1;
    self.pageController.numberOfPages = 5;
    self.pageController.sourceScrollView = caroselScrollView;
    [self.pageController prepareShow];
    [self.view addSubview:self.pageController];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    [self.pageController scrollviewForPageControllerDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    NSLog(@">>>>>>>>>>>>>.");
//    int selected_Num = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);

//    [self.pageController scrollViewForPageControllerDidEndDecelerating:scrollView];
//    [self setPageControlSelectedPageNumber:selected_Num];
}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//
//    int selected_Num = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
////    [self setPageControlSelectedPageNumber:selected_Num];
//}


@end
