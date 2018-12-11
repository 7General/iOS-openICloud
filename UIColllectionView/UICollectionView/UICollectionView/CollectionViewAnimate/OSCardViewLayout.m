//
//  BJCardViewLayout.m
//  UICollectionView
//
//  Created by zzg on 2018/12/11.
//  Copyright © 2018年 zzg. All rights reserved.
//

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

#import "OSCardViewLayout.h"

@interface OSCardViewLayout()

@property (nonatomic, assign) NSInteger  columnCount;
@property (nonatomic, assign) CGFloat  columnSpace;
@property (nonatomic, assign) CGFloat  rowSpace;
@property (nonatomic, assign) UIEdgeInsets  sectionInsets;

@property (nonatomic, assign) CGFloat  contentX;

@property (nonatomic, strong) NSMutableArray * attributesArray;
@property (nonatomic, strong) NSMutableArray * deleteIndexPaths;
@property (nonatomic, strong) NSMutableArray * insertIndexPaths;
@end

@implementation OSCardViewLayout

// 1、准备布局，布局初始化一般在这里进行
-(void)prepareLayout {
    [super prepareLayout];
    NSLog(@"1:prepareLayout");
    self.columnCount = [self.collectionView numberOfItemsInSection:0];
    self.columnSpace = 20.0f;
    self.rowSpace = 10.0f;
//    self.sectionInsets = UIEdgeInsetsMake(5.0f, self.collectionView.bounds.size.width*0.35, 5.0f, self.collectionView.bounds.size.width*0.35);
//    self.sectionInsets = UIEdgeInsetsZero;
//    self.sectionInsets = UIEdgeInsetsMake(5.0f, self.collectionView.bounds.size.width*0.4, 5.0f, self.collectionView.bounds.size.width*0.4);
//    self.contentX = self.sectionInsets.left;
    
    
    CGFloat width = self.collectionView.bounds.size.width;
    CGFloat height = self.collectionView.bounds.size.height;
    
    CGFloat w = width * 0.3;
    CGFloat h = height * 0.2;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.itemSize = CGSizeMake(w, h);
}

/*
 UICollectionViewLayoutAttributes 布局属性
 该属性可以拿到每个Cell、SupplementaryView、DecorationView的布局属性，反过来，collection view 使用该属性将cell和SupplementaryView放在其边界内。
 */

// 2、初始化布局时调用，返回特定rect(有可能是也可能不是可见rect)，每个cell和Supplementary和Decoration的布局属性

/*
 返回UICollectionViewLayoutAttributes 类型的数组，
 UICollectionViewLayoutAttributes 对象包含cell或view的布局信息。
 子类必须重载该方法，并返回该区域内所有元素的布局信息，包括cell,追加视图和装饰视图。
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSLog(@"3：layoutAttributesForElementsInRect");
    [self.attributesArray removeAllObjects];
    for (NSInteger index = 0; index < [self.collectionView numberOfItemsInSection:0]; index++) {
        UICollectionViewLayoutAttributes * attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        [self.attributesArray addObject:attributes];
    }
    return self.attributesArray;
}
/*
 CGRect frame 布局视图的frame简单明了
 CGPoint center 视图中心点
 CGSize size 视图尺寸
 CATransform3D transform3D 这个属性可以用来做酷炫的3D动画
 CGAffineTransform transform 转场属性
 CGFloat alpha 透明度
 NSInteger zIndex 层级，数字越大，层级越高（最上面）。
 NSIndexPath *indexPath 如果是cell有对应的indexPath
 UICollectionElementCategory representedElementCategory 视图标记，是cell还是supplementary View或者decoration View
 registerClass:forDecorationViewOfKind: 注册decoration View
 registerNib:forDecorationViewOfKind:
 +(instancetype)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind withIndexPath:(NSIndexPath *)indexPath 这个类方法是decoration View布局的来源
 -(nullable UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath 与上一个方法结合得到decoration View布局
 */

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//
//    NSLog(@"4：layoutAttributesForItemAtIndexPath");
//    CGFloat width = self.collectionView.bounds.size.width;
//    CGFloat height = self.collectionView.bounds.size.height;
//
//    CGFloat w = width * 0.3;
//    CGFloat h = height * 0.2;
//
//    CGFloat x = self.sectionInsets.left + (self.columnSpace + w) * indexPath.item;
//    CGFloat y = height * 0.4;
//
//    attributes.frame = CGRectMake(x, y, w, h);
//
//
////    self.contentX = attributes.frame.origin.x + attributes.frame.size.width;
//
////    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
////
////    CGFloat delta = ABS(attributes.center.x - centerX);
////    CGFloat scale = 1.0 - delta / self.collectionView.frame.size.width;
////    attributes.transform = CGAffineTransformMakeScale(scale, scale);
////
////    attributes.alpha = scale;
//
//    return attributes;
//
//}

/*
 返回collectionView内容区的宽度和高度，子类必须重载该方法，
 返回值代表了所有内容的宽度和高度，而不仅仅是可见范围的，
 collectionView通过该信息配置它的滚动范围，默认返回 CGSizeZero。
 */
// 由于我们变成了横向布局，所以我们就该改变collectionview的滑动范围
//- (CGSize) collectionViewContentSize {
//    NSLog(@"2:collectionViewContentSize");
//    return CGSizeMake(self.contentX + self.sectionInsets.right, 0);
//}

// 当滚动停止时，会调用该方法确定collectionView滚动到的位置
/*
 //在使用UICollectionViewFlowLayout布局的时候，有时会有特别的需求，比如：
 //当一个cell滑动到屏幕中点的时候放大，并且当我停止滑动时，能够将离屏幕最近的cell居中。
 //这四个方法就能轻松的完成这样的事。
 */
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//    NSLog(@"5:targetContentOffsetForProposedContentOffset");
//
//    CGFloat midCenterX = self.collectionView.center.x;
//    CGFloat carWidth = self.collectionView.bounds.size.width * 0.3;
//
//    CGFloat realMidx = proposedContentOffset.x + midCenterX;
//    // X/Y = 浮点余数 (两数 取余)
//    // 滑动的内容的中心点对每个完整的item求余，获得证书item以外的偏移量
//    CGFloat more = fmodf(realMidx - self.sectionInsets.left, carWidth + self.columnSpace);
//    //上行获取的偏移量对Item中心点的间距，也就是我们的偏移量需要再增加的偏移量。
//    //返回这个经过计算的偏移量，系统会帮我们无痕的完整偏移。
//    return CGPointMake(proposedContentOffset.x - (more - carWidth/ 2.0), 0);
//}

// 每当collectionView边界改变时便调用这个方法询问 是否 重新初始化布局 是则调用prepareLayout准备布局
/*
 该方法用来决定是否需要更新布局。如果collection view需要重新布局返回YES,否则返回NO,默认返回值为NO。
 子类重载该方法的时候，基于是否collectionview的bounds的改变会引发cell和view布局的改变(滚动屏幕cell或者view会不会变)，给出正确的返回值。
 如果返回YES，UICollectionView通过调用invalidateLayoutWithContext方法使原来的layout失效
 
 这些方法为collection view 在屏幕上布局提供了最基础的布局信息，如果你不想为追加视图和装饰视图布局，可以不去重载相应的方法。
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    NSLog(@"shouldInvalidateLayoutForBoundsChange");
    return YES;
}



//- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
//{
//    [super prepareForCollectionViewUpdates:updateItems];
//
//    NSLog(@"准备改变");
//
//    UICollectionViewUpdateItem *update = updateItems[0];
//    NSLog(@"%ld -- %ld",update.indexPathBeforeUpdate.section,update.indexPathBeforeUpdate.row);
//    NSLog(@"%ld -- %ld",update.indexPathAfterUpdate.section,update.indexPathAfterUpdate.row);
//    NSLog(@"%ld",update.updateAction);
//
//
//    self.deleteIndexPaths = [NSMutableArray array];
//    self.insertIndexPaths = [NSMutableArray array];
//
//    for (UICollectionViewUpdateItem *update in updateItems)
//    {
//        if (update.updateAction == UICollectionUpdateActionDelete)
//        {
//            [self.deleteIndexPaths addObject:update.indexPathBeforeUpdate];
//        }
//        else if (update.updateAction == UICollectionUpdateActionInsert)
//        {
//            [self.insertIndexPaths addObject:update.indexPathAfterUpdate];
//        }
//    }
//}
//
//-(UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//    NSLog(@"插入动画 ： %ld -- %ld ",itemIndexPath.section,itemIndexPath.row);
//
//    UICollectionViewLayoutAttributes * att = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
//
//    if ([self.insertIndexPaths containsObject:itemIndexPath]) {
//        if (!att) {
//            att = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
//        }
//
//        att.alpha = 0.1f;
//    }
//
//    return att;
//}
//
//-(UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//    NSLog(@"删除动画 ： %ld -- %ld ",itemIndexPath.section,itemIndexPath.row);
//
//    UICollectionViewLayoutAttributes * att = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
//
//    if ([self.deleteIndexPaths containsObject:itemIndexPath]) {
//        if (!att) {
//            att = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
//        }
//
//        att.alpha = 1.0f;
//        att.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(90));
//
//    }
//
//    return att;
//}
//
//- (void)finalizeCollectionViewUpdates
//{
//    [super finalizeCollectionViewUpdates];
//
//    NSLog(@"完成改变");
//
//    self.deleteIndexPaths = nil;
//    self.insertIndexPaths = nil;
//}

#pragma mark - initializes attributes

-(NSMutableArray *)attributesArray
{
    if (!_attributesArray) {
        _attributesArray = [[NSMutableArray alloc] init];
    }
    
    return _attributesArray;
}


@end
