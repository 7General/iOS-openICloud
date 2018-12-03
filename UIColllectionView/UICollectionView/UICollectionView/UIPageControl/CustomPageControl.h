//
//  CustomPageControl.h
//  UICollectionView
//
//  Created by zzg on 2018/11/30.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZIMCarouselProtocol.h"




@interface CustomPageControl : UIView<GZIMCarouselPageControlProtocol>
/**
 总页数
 */
@property (nonatomic, assign) NSInteger         pageNumbers;
/**
 当前页
 */
@property (nonatomic, assign) NSInteger         currentPage;

@end
