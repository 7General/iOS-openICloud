//
//  ShareView.m
//  WKWebView
//
//  Created by zzg on 2018/12/22.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "GZIMSheetOpenView.h"
#import "GZIMSheetOpenEntity.h"
#import "GZIMSheetOpenCell.h"

#define CurrentWindow [self getCurrentWindowView]
#define DDMWIDTH [UIScreen mainScreen].bounds.size.width
#define DDMHEIGHT [UIScreen mainScreen].bounds.size.height
#define DDMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


#define SHEETHEIGHT 193
#define COLLECTIONHEIGHT 132

static CGFloat kMagin = 10.f;

@interface GZIMSheetOpenView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *carouselView;


@property (nonatomic, weak) UIView * mainView;


@property (nonatomic, assign) NSInteger  selectIndex;

@end

@implementation GZIMSheetOpenView



- (instancetype)initWithBottomTitle:(NSString *)title {
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.frame = CurrentWindow.frame;
    [CurrentWindow addSubview:self];
    
    
    UIButton * test = [UIButton buttonWithType:UIButtonTypeCustom];
    test.frame = self.frame;
    [test addTarget:self action:@selector(dismisView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:test];
    
    UIView * mainView = [[UIView alloc] initWithFrame:CGRectMake(0, DDMHEIGHT, DDMWIDTH, SHEETHEIGHT)];
    [self addSubview:mainView];
    self.mainView = mainView;
    
}

- (void)dismisViewTap {
    NSLog(@"-=-=--=dismisViewTap");
}

-(void)setDataSource:(id<GZIMSheetOpenViewDataSource>)dataSource {
    _dataSource = dataSource;
    
    [self.mainView addSubview:self.carouselView];

    UIButton * cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.backgroundColor = [UIColor whiteColor];
    cancleButton.frame = CGRectMake(0, CGRectGetMaxY(self.carouselView.frame), self.frame.size.width, 59);
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancleButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(dismisView) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:cancleButton];

    UIView * centerLine = [[UIView alloc] initWithFrame:CGRectMake(22, 0.5, self.frame.size.width - 44, 0.5)];
    centerLine.backgroundColor = [UIColor grayColor];
    [cancleButton addSubview:centerLine];

    
}

#pragma mark UICollectionViewDelegate  UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(SheetShare:numberOfItemsInSection:)]) {
        return [self.dataSource SheetShare:self numberOfItemsInSection:section];
    } else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GZIMSheetOpenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tempCell" forIndexPath:indexPath];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(SheetShare:cellForIndexPath:)]) {
        GZIMSheetOpenEntity * item = [self.dataSource SheetShare:self cellForIndexPath:indexPath];
        [cell setItemText:item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectItemAtIndexPathdidSelectItemAtIndexPath");
    if (self.delegate && [self.delegate respondsToSelector:@selector(SheetShare:didSelectedIndexPath:)]) {
        [self.delegate SheetShare:self didSelectedIndexPath:indexPath];
    }
}


- (UICollectionViewFlowLayout *)createViewFlowLayout {
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat itemWidth = 75;
    //设置单元格大小
    flowLayout.itemSize = CGSizeMake(itemWidth, 90);
    //设置senction的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(20, kMagin, 20, kMagin);
    //设置UICollectionView的滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return flowLayout;
}

#pragma mark - < getter >
- (UICollectionView *)carouselView {
    if(!_carouselView) {
        _carouselView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, COLLECTIONHEIGHT) collectionViewLayout:[self createViewFlowLayout]];
        _carouselView.clipsToBounds = NO;
        _carouselView.delegate = self;
        _carouselView.dataSource = self;
        _carouselView.backgroundColor = [UIColor whiteColor];
        _carouselView.showsVerticalScrollIndicator = NO;
        _carouselView.showsHorizontalScrollIndicator = NO;
        
        [_carouselView registerClass:[GZIMSheetOpenCell class] forCellWithReuseIdentifier:@"tempCell"];
    }
    return _carouselView;
}



-(void)dismisView {
    [UIView animateWithDuration:0.33 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.mainView.frame = CGRectMake(0, DDMHEIGHT, DDMWIDTH, SHEETHEIGHT);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)show {
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        CGRect rect = CGRectMake(0, DDMHEIGHT - SHEETHEIGHT, DDMWIDTH, SHEETHEIGHT);
        self.mainView.frame = rect;
    }];
}

/**获取当前window*/
- (UIWindow *)getCurrentWindowView {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    return window;
}


@end
