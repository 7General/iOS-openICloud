//
//  BJCardViewLayout.m
//  UICollectionView
//
//  Created by zzg on 2018/12/11.
//  Copyright © 2018年 zzg. All rights reserved.
//

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

#import "BJCardViewLayout.h"

@interface BJCardViewLayout()
@property (nonatomic, assign) NSInteger  columnCount;
@property (nonatomic, assign) CGFloat  columnSpace;
@property (nonatomic, assign) CGFloat  rowSpace;
@property (nonatomic, assign) UIEdgeInsets  sectionInsets;

@property (nonatomic, assign) CGFloat  contentX;

@property (nonatomic, strong) NSMutableArray * attributesArray;
@property (nonatomic, strong) NSMutableArray * deleteIndexPaths;
@property (nonatomic, strong) NSMutableArray * insertIndexPaths;
@end

@implementation BJCardViewLayout

-(void)prepareLayout {
    [super prepareLayout];
    self.columnCount = [self.collectionView numberOfItemsInSection:0];
    self.columnSpace = 20.0f;
    self.rowSpace = 10.0f;
    self.sectionInsets = UIEdgeInsetsMake(5.0f, self.collectionView.bounds.size.width * 0.35, 5.0f,self.collectionView.bounds.size.width * 0.35);
    self.contentX = self.sectionInsets.left;
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
    CGFloat h = height * 0.3;
    
    CGFloat x = self.sectionInsets.left + (self.columnSpace + w) * indexPath.item;
    CGFloat y = height * 0.4;
    
    attributes.frame = CGRectMake(x, y, w, h);
    
    
    self.contentX = attributes.frame.origin.x + attributes.frame.size.width;
    
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    CGFloat delta = ABS(attributes.center.x - centerX);
    CGFloat scale = 1.0 - delta/ self.collectionView.frame.size.width;
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    
    attributes.alpha = scale;
    
    return attributes;
    
}

- (CGSize) collectionViewContentSize {
    return CGSizeMake(self.contentX + self.sectionInsets.right, 0);
}
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat midCenterX = self.collectionView.center.x;
    CGFloat carWidth = self.collectionView.bounds.size.width * 0.3;
    
    CGFloat realMidx = proposedContentOffset.x + midCenterX;
    
    CGFloat more = fmodf(realMidx - self.sectionInsets.left, carWidth + self.columnSpace);
    
    return CGPointMake(proposedContentOffset.x - (more - carWidth/ 2.0), 0);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}


@end
