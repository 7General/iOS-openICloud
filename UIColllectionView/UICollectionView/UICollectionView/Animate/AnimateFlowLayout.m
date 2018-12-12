//
//  AnimateFlowLayout.m
//  UICollectionView
//
//  Created by zzg on 2018/12/12.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "AnimateFlowLayout.h"

@interface AnimateFlowLayout()

@property (nonatomic, strong) NSMutableArray * attributesArray;


@property (nonatomic, assign) CGFloat  contentX;
@end


@implementation AnimateFlowLayout
-(void)prepareLayout {
    [super prepareLayout];
    
    CGFloat itemWidth = 100;
    self.itemSize = CGSizeMake(itemWidth, itemWidth / 0.68);
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    self.headerReferenceSize = CGSizeMake(100, 0);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    [self.attributesArray removeAllObjects];
    for (NSInteger index = 0; index < [self.collectionView numberOfItemsInSection:0]; index++) {
        UICollectionViewLayoutAttributes * attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        [self.attributesArray addObject:attributes];
    }
    return self.attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat width = self.collectionView.bounds.size.width;
    CGFloat height = self.collectionView.bounds.size.height;

    CGFloat w = width * 0.3;
    CGFloat h = height * 0.2;

    CGFloat x = self.sectionInset.left + (10 + w) * indexPath.item;
    CGFloat y = height * 0.4;

    attributes.frame = CGRectMake(x, y, w, h);

    self.contentX = attributes.frame.origin.x + attributes.frame.size.width;
    
    
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;

    CGFloat delta = ABS(attributes.center.x - centerX);
    CGFloat scale = 1.0 - delta / self.collectionView.frame.size.width;
    attributes.transform = CGAffineTransformMakeScale(scale, scale);

    attributes.alpha = scale;

    return attributes;

}
//- (CGSize)collectionViewContentSize {
//    return CGSizeMake(self.contentX + self.sectionInset.right + self.collectionView.bounds.size.width * 0.3 + 10 , 0);
//}

-(NSMutableArray *)attributesArray {
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray new];
    }
    return _attributesArray;
}

@end
