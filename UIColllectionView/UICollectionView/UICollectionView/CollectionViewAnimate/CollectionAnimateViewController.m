//
//  CollectionAnimateViewController.m
//  UICollectionView
//
//  Created by zzg on 2018/12/11.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "CollectionAnimateViewController.h"
#import "BJCardViewLayout.h"
#import "BJCardCell.h"
#import "BJCardModel.h"

@interface CollectionAnimateViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView * cardCollectionView;

@property (nonatomic , strong) NSArray * dataArray;
@end

@implementation CollectionAnimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.cardCollectionView];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BJCardCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[BJCardCell reuseIdentifier] forIndexPath:indexPath];
    
    cell.contentView.frame = cell.bounds;
    cell.contentView.backgroundColor = [UIColor grayColor];
    
    BJCardModel * model = self.dataArray[indexPath.row];
    
    cell.title = model.indexStr;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    __block CollectionAnimateViewController * weakself = self;
    if (indexPath.row%2) {
        [self.cardCollectionView performBatchUpdates:^{
            NSMutableArray * theArray = [NSMutableArray arrayWithArray:self.dataArray];
            BJCardModel * model = [BJCardModel new];
            model.indexStr = [NSString stringWithFormat:@"%ld",theArray.count];
            [theArray addObject:model];
            weakself.dataArray = [NSArray arrayWithArray:theArray];
            
            NSIndexPath * indexpath = [NSIndexPath indexPathForItem:self.dataArray.count-1 inSection:0];
            [weakself.cardCollectionView insertItemsAtIndexPaths:@[indexpath]];
            
        } completion:nil];
    }else{
        [self.cardCollectionView performBatchUpdates:^{
            NSMutableArray * theArray = [NSMutableArray arrayWithArray:self.dataArray];
            [theArray removeLastObject];
            weakself.dataArray = [NSArray arrayWithArray:theArray];
            
            NSIndexPath * indexpath = [NSIndexPath indexPathForItem:self.dataArray.count inSection:0];
            [weakself.cardCollectionView deleteItemsAtIndexPaths:@[indexpath]];
            
        } completion:nil];
    }
    
}

#pragma mark - initializes attributes

-(UICollectionView *)cardCollectionView
{
    if (!_cardCollectionView) {
        BJCardViewLayout * layout = [BJCardViewLayout new];
        
        _cardCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _cardCollectionView.backgroundColor = [UIColor whiteColor];
        _cardCollectionView.delegate = self;
        _cardCollectionView.dataSource = self;
        
        [_cardCollectionView registerClass:[BJCardCell class] forCellWithReuseIdentifier:[BJCardCell reuseIdentifier]];
    }
    
    return _cardCollectionView;
}

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSArray alloc] init];
        
        NSMutableArray * theArray = [NSMutableArray array];
        for (NSInteger index = 0; index < 10; index++) {
            BJCardModel * model = [BJCardModel new];
            model.indexStr = [NSString stringWithFormat:@"%ld",index];
            [theArray addObject:model];
        }
        
        _dataArray = [NSArray arrayWithArray:theArray];
    }
    
    return _dataArray;
}



@end
