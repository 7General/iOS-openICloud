//
//  CollectionAnimateViewController.m
//  UICollectionView
//
//  Created by zzg on 2018/12/11.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "CollectionAnimateViewController.h"
#import "OSCardViewLayout.h"
#import "OSCardCell.h"
#import "OSCardModel.h"

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
    OSCardCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[OSCardCell reuseIdentifier] forIndexPath:indexPath];
    
    cell.contentView.frame = cell.bounds;
    cell.contentView.backgroundColor = [UIColor grayColor];
    
    OSCardModel * model = self.dataArray[indexPath.row];
    
    cell.title = model.indexStr;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    __block CollectionAnimateViewController * weakself = self;
//    if (indexPath.row%2) {
//        [self.cardCollectionView performBatchUpdates:^{
//            NSMutableArray * theArray = [NSMutableArray arrayWithArray:self.dataArray];
//            OSCardModel * model = [OSCardModel new];
//            model.indexStr = [NSString stringWithFormat:@"%ld",theArray.count];
//            [theArray addOOSect:model];
//            weakself.dataArray = [NSArray arrayWithArray:theArray];
//            
//            NSIndexPath * indexpath = [NSIndexPath indexPathForItem:self.dataArray.count-1 inSection:0];
//            [weakself.cardCollectionView insertItemsAtIndexPaths:@[indexpath]];
//            
//        } completion:nil];
//    }else{
//        [self.cardCollectionView performBatchUpdates:^{
//            NSMutableArray * theArray = [NSMutableArray arrayWithArray:self.dataArray];
//            [theArray removeLastOOSect];
//            weakself.dataArray = [NSArray arrayWithArray:theArray];
//            
//            NSIndexPath * indexpath = [NSIndexPath indexPathForItem:self.dataArray.count inSection:0];
//            [weakself.cardCollectionView deleteItemsAtIndexPaths:@[indexpath]];
//            
//        } completion:nil];
//    }
    
}

#pragma mark - initializes attributes

-(UICollectionView *)cardCollectionView
{
    if (!_cardCollectionView) {
        OSCardViewLayout * layout = [OSCardViewLayout new];
        
        _cardCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _cardCollectionView.backgroundColor = [UIColor whiteColor];
        _cardCollectionView.delegate = self;
        _cardCollectionView.dataSource = self;
        
        [_cardCollectionView registerClass:[OSCardCell class] forCellWithReuseIdentifier:[OSCardCell reuseIdentifier]];
    }
    
    return _cardCollectionView;
}

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSArray alloc] init];
        
        NSMutableArray * theArray = [NSMutableArray array];
        for (NSInteger index = 0; index < 10; index++) {
            OSCardModel * model = [OSCardModel new];
            model.indexStr = [NSString stringWithFormat:@"%ld",index];
            [theArray addObject:model];
        }
        
        _dataArray = [NSArray arrayWithArray:theArray];
    }
    
    return _dataArray;
}



@end
