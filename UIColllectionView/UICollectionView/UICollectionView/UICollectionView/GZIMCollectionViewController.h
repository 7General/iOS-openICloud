//
//  GZIMCollectionViewController.h
//  UICollectionView
//
//  Created by zzg on 2018/11/13.
//  Copyright © 2018年 zzg. All rights reserved.
//




#define kGZIM_SCREEN_WIDTH          [UIScreen mainScreen].bounds.size.width
#define kGZIM_SCREEN_HEIGHT         [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>


FOUNDATION_EXPORT NSString * const GZIMCollectionViewHeaderIdentifier;
FOUNDATION_EXPORT NSString * const GZIMCollectionViewFooterIdentifier;

@interface GZIMCollectionViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong, readonly) UICollectionView *collectionView;

// impl by subclass
- (UICollectionViewFlowLayout *)collectionViewFlowLayout;

@end
