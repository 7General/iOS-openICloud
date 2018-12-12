//
//  AnimateViewController.m
//  UICollectionView
//
//  Created by zzg on 2018/12/11.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "AnimateViewController.h"
#import "AnimateFlowLayout.h"

static NSString * identifier = @"osCellID";
static CGFloat kMagin = 10.f;
static NSString * headIdentifier = @"osHeadID";

@interface AnimateViewController ()<UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * collectionView;
//@property (nonatomic, strong) AnimateFlowLayout * flowLayout;

@end

@implementation AnimateViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    [array addObject:@"1"];
    
    NSInteger index = array.count ? array.count : 0;
    [array insertObject:@"2" atIndex:index];
    
    if (array.count) {
        [array removeObjectAtIndex:array.count - 1];
    }
    
    NSLog(@"--->>>%@",array);
//    [array removeObjectAtIndex:0];
}


#pragma mark - deleDate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if (kind == UICollectionElementKindSectionHeader) {
//        UICollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier forIndexPath:indexPath];
//        header.backgroundColor = [UIColor yellowColor];
//        return header;
//    }
//    return nil;
//}


#pragma mark -setter getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        AnimateFlowLayout *flowLayout = [AnimateFlowLayout new];
        CGFloat itemWidth = (self.view.frame.size.width - 4 * kMagin) / 3;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, (itemWidth / 0.618) + 100) collectionViewLayout:flowLayout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier];
        _collectionView.dataSource = self;
    }
    return _collectionView;
    
}
- (UICollectionViewFlowLayout *)createViewFlowLayout {
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat itemWidth = (self.view.frame.size.width - 4 * kMagin) / 3;
    //设置单元格大小
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth / 0.618);
    //设置senction的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(kMagin, kMagin, kMagin, kMagin);
    //设置UICollectionView的滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //sectionHeader的大小,如果是竖向滚动，只需设置Y值。如果是横向，只需设置X值。
    flowLayout.headerReferenceSize = CGSizeMake(100,0);
    return flowLayout;
}

@end
