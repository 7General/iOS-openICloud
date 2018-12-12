//
//  ShufflingView.h
//  UICollectionView
//
//  Created by zzg on 2018/12/12.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShuffingFlowLayout.h"

@interface ShufflingView : UIView

/**
 布局自定义layout
 */
@property (nonatomic, strong, readonly) ShuffingFlowLayout    * _Nonnull flowLayout;


- (instancetype _Nullable )initWithFrame:(CGRect)frame
                              flowLayout:(nonnull ShuffingFlowLayout *)flowLayout;


@end
