//
//  ShuffingFlowLayout.m
//  UICollectionView
//
//  Created by zzg on 2018/12/12.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "ShuffingFlowLayout.h"

@interface ShuffingFlowLayout()
/**
 默认轮播图宽度
 */
@property (nonatomic, assign) CGFloat                   defaultItemWidth;
@property (nonatomic, assign) CGFloat                   factItemSpace;

@property (nonatomic, strong) NSMutableArray * attributesArray;


@end

@implementation ShuffingFlowLayout

-(void)prepareLayout {
    CGFloat width = CGRectGetWidth(self.collectionView.frame);
    CGFloat height = CGRectGetHeight(self.collectionView.frame);
    self.itemWidth = width;
    self.itemSize = CGSizeMake(width * 0.3, height * 0.5);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 70;
    self.maxScale = 1.2;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

/**
 *  这个方法的返回值是一个数组(数组里存放在rect范围内所有元素的布局属性)
 *  这个方法的返回值  决定了rect范围内所有元素的排布（frame）
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray * array = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    CGFloat centetX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    CGFloat maxScale = 0;
    UICollectionViewLayoutAttributes *tempAttris = nil;
    for (UICollectionViewLayoutAttributes * attrs in array) {
        
        //cell的中心点x 和CollectionView最中心点的x值
        CGFloat space = ABS(attrs.center.x - centetX);
        if (space > 0) {
            //这里scale 必须要 小于1
            CGFloat scale = 1 - space/self.collectionView.frame.size.width;
            //scale = - ((1.2 - 1) / self.itemWidth) * space + 1.2;
            //设置缩放比例
            attrs.transform=CGAffineTransformMakeScale(scale, scale);
            
//            if(maxScale < scale) {
//                maxScale = scale;
//                tempAttris = attrs;
//            }
        }
//        attrs.zIndex = 0;
    }
//    if (tempAttris) {
//        tempAttris.zIndex = 1;
//    }
    return array;
    
    
    //    NSArray<UICollectionViewLayoutAttributes *> *arr = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    //    CGFloat centerX = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.frame) * 0.5;
    //    CGFloat width = self.itemWidth;
    //    __block CGFloat maxScale = 0;
    //    __block UICollectionViewLayoutAttributes *attri = nil;
    //    [arr enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        CGFloat space = ABS(obj.center.x - centerX);
    //        if(space > 0) {
    //            CGFloat scale = 1;
    //            scale = -((self.maxScale - 1) / width) * space + self.maxScale;
    //            obj.transform = CGAffineTransformMakeScale(scale, scale);
    //            if(maxScale < scale) {
    //                maxScale = scale;
    //                attri = obj;
    //            }
    //        }
    //        obj.zIndex = 0;
    //    }];
    //    if (attri) {
    //        attri.zIndex = 1;
    //    }
    //    return arr;
    
    
    
    
}

- (void)setMaxScale:(CGFloat)maxScale {
    _maxScale = maxScale;
    if(maxScale < 1) {
        _maxScale = 1;
    }
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    return proposedContentOffset;
}

-(NSMutableArray *)attributesArray {
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray new];
    }
    return _attributesArray;
}


@end

