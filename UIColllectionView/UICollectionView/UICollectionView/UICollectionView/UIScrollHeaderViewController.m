//
//  UIScrollHeaderViewController.m
//  UICollectionView
//
//  Created by zzg on 2018/11/30.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "UIScrollHeaderViewController.h"
#import "GZIMCarousel.h"
#import "CustomPageControl.h"


@interface UIScrollHeaderViewController ()<GZIMCarouselDelegate,GZIMCarouselDatasource,GZIMCarouselPageControlProtocol>

@property (nonatomic, strong) GZIMCarousel * carousel;

@property (nonatomic, strong) UIView *animationView;

@property (nonatomic, strong) CustomPageControl * customPageController;


@end

@implementation UIScrollHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
}


- (void)configUI {
    
    if(self.carousel) {
        [self.carousel releaseTimer];
        [self.carousel removeFromSuperview];
        self.carousel = nil;
    }
    
    
    
    [self.view addSubview:self.animationView];

    self.customPageController = [[CustomPageControl alloc] initWithFrame:CGRectMake(0, 110, self.animationView.frame.size.width, 40)];
    self.customPageController.backgroundColor =[UIColor redColor];
//    [self.view addSubview:self.customPageController];
    
    
    GZIMFlowLayout *flowLayout = [[GZIMFlowLayout alloc] initWithStyle:CWCarouselStyle_H_1];
    flowLayout.itemWidth = 330;
    flowLayout.itemSpace_H = 10;
    
    GZIMCarousel * carousel = [[GZIMCarousel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 110)
                                                         delegate:self
                                                       datasource:self
                                                       flowLayout:flowLayout];

    carousel.customPageControl = self.customPageController;
    [self.animationView addSubview:carousel];
    
    carousel.isAuto = YES;
    carousel.autoTimInterval = 4;
    carousel.endless = YES;
    carousel.backgroundColor = [UIColor whiteColor];
    [carousel registerViewClass:[UICollectionViewCell class] identifier:@"cellId"];
    [carousel freshCarousel];
    self.carousel = carousel;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.carousel controllerWillAppear];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.carousel controllerWillDisAppear];
    [self.animationView removeFromSuperview];
}

#pragma mark - delegate
-(NSInteger)numbersForCarousel {
    return 5;
}

#pragma mark - Delegate
- (UICollectionViewCell *)viewForCarousel:(GZIMCarousel *)carousel indexPath:(NSIndexPath *)indexPath index:(NSInteger)index{
    UICollectionViewCell *cell = [carousel.carouselView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor cyanColor];
    UIImageView *imgView = [cell.contentView viewWithTag:666];
    if(!imgView) {
        imgView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imgView.tag = 666;
        imgView.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:imgView];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 8;
    }
    
    NSString *name = [NSString stringWithFormat:@"%02ld.jpg", index + 1];
    UIImage *img = [UIImage imageNamed:name];
    if(!img) {
        NSLog(@"%@", name);
    }
    [imgView setImage:img];
    return cell;
}


- (void)GZIMCarousel:(GZIMCarousel *)carousel didSelectedAtIndex:(NSInteger)index {
    NSLog(@"----->>>%ld",index);
}



- (UIView *)animationView{
    if(!_animationView) {
        _animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 240, CGRectGetWidth(self.view.frame), 110)];
        _animationView.backgroundColor = [UIColor greenColor];
    }
    return _animationView;
}


@end
