//
//  GZIMCollectionViewController.m
//  UICollectionView
//
//  Created by zzg on 2018/11/13.
//  Copyright © 2018年 zzg. All rights reserved.
//




#import "GZIMCollectionViewController.h"

NSString * const GZIMCollectionViewHeaderIdentifier = @"GZIMCollectionViewHeaderIdentifier";
NSString * const GZIMCollectionViewFooterIdentifier = @"GZIMCollectionViewFooterIdentifier";

@interface GZIMCollectionViewController ()
@property (nonatomic, strong, readwrite) UICollectionView *collectionView;
@end

@implementation GZIMCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}


#pragma mark - 创建collectionView并设置代理
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [self collectionViewFlowLayout];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kGZIM_SCREEN_WIDTH, kGZIM_SCREEN_HEIGHT) collectionViewLayout:flowLayout];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GZIMCollectionViewHeaderIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GZIMCollectionViewFooterIdentifier];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.alwaysBounceVertical = YES;
        
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:GZIMCollectionViewHeaderIdentifier forIndexPath:indexPath];
        return headView;
    }
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:GZIMCollectionViewFooterIdentifier forIndexPath:indexPath];
        return footView;
    }
    return nil;
}


// impl by subclass
- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    return nil;
}

@end
