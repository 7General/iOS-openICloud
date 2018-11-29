//
//  MainViewController.m
//  UICollectionView
//
//  Created by zzg on 2018/11/13.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "MainViewController.h"
#import "GZIMWorkspaceHeader.h"
#import "GZIMWorkspaceSectionFoot.h"
#import "GZIMWorkspaceItemCell.h"

static NSString * const GZWorkspaceItemReuseIdentifier = @"GZWorkspaceItemReuseIdentifier";

@interface MainViewController ()<CustomCollectionViewDelete>

@property (nonatomic, strong) NSMutableArray * departArry;
@property (nonatomic, strong) NSMutableArray * roomArry;
@property (nonatomic, strong) NSMutableArray * userArry;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self addData];
    
    
//    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    /* 注册header和foot */
    [self.collectionView registerClass:[GZIMWorkspaceHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GZIMCollectionViewHeaderIdentifier];
    [self.collectionView registerClass:[GZIMWorkspaceSectionFoot class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GZIMCollectionViewFooterIdentifier];
    
    [self.collectionView registerClass:[GZIMWorkspaceItemCell class] forCellWithReuseIdentifier:GZWorkspaceItemReuseIdentifier];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.collectionView addGestureRecognizer:longPressGesture];
}




- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    // 获取此次点击的坐标，根据坐标获取cell对应的indexPath
    CGPoint point = [longPress locationInView:self.collectionView];
    NSIndexPath * indexPath = [self.collectionView indexPathForItemAtPoint:point];
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (!indexPath) {
                break;
            }
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.collectionView updateInteractiveMovementTargetPosition:point];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (0 == indexPath.item || self.departArry.count - 1 == indexPath.item) {
                [self.collectionView cancelInteractiveMovement];
            } else {
               [self.collectionView endInteractiveMovement];
            }
            
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            [self.collectionView cancelInteractiveMovement];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 拖动
// 在开始移动时会调用此代理方法，
-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    //根据indexpath判断单元格是否可以移动，如果都可以移动，直接就返回YES ,不能移动的返回NO
    if (0 == indexPath.item || self.departArry.count - 1 == indexPath.item) {
        return NO;
    }
    return YES;
}
// 在移动结束的时候调用此代理方法
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    /**
     *sourceIndexPath 原始数据 indexpath
     * destinationIndexPath 移动到目标数据的 indexPath
     */
    if (0 == destinationIndexPath.item || self.departArry.count - 1 == sourceIndexPath.item) return;
    NSString * insertItem = self.departArry[sourceIndexPath.item];
    [self.departArry removeObjectAtIndex:sourceIndexPath.item];
    [self.departArry insertObject:insertItem atIndex:destinationIndexPath.item];
}


- (void)addData {
    [self.departArry addObject:@"1"];
    [self.departArry addObject:@"2"];
    [self.departArry addObject:@"3"];
    [self.departArry addObject:@"4"];
    [self.departArry addObject:@"5"];
    [self.departArry addObject:@"6"];
    [self.departArry addObject:@"7"];
    [self.departArry addObject:@"8"];
    [self.departArry addObject:@"9"];
    [self.departArry addObject:@"10"];
    [self.departArry addObject:@"11"];
    [self.departArry addObject:@"12"];
    [self.departArry addObject:@"13"];
    [self.departArry addObject:@"14"];
    [self.departArry addObject:@"15"];
    [self.departArry addObject:@"16"];
    [self.departArry addObject:@"17"];
    [self.departArry addObject:@"18"];
    [self.departArry addObject:@"19"];
    [self.departArry addObject:@"20"];
    
    [self.roomArry addObject:@"1"];
    [self.roomArry addObject:@"2"];
    [self.roomArry addObject:@"3"];
    [self.roomArry addObject:@"4"];
    [self.roomArry addObject:@"5"];
    [self.roomArry addObject:@"6"];
    [self.roomArry addObject:@"7"];
    
    [self.userArry addObject:@"1"];
    [self.userArry addObject:@"2"];
    [self.userArry addObject:@"3"];
    [self.userArry addObject:@"4"];
    [self.userArry addObject:@"5"];
    [self.userArry addObject:@"6"];
    [self.userArry addObject:@"7"];
    [self.userArry addObject:@"8"];
    [self.userArry addObject:@"9"];
    [self.userArry addObject:@"10"];
    
}


#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return   1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.departArry.count;
    } else if(section == 1) {
        return self.roomArry.count;
    } else if(section == 2){
        return self.userArry.count;
    } else {
        return 0;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        GZIMWorkspaceHeader * headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:GZIMCollectionViewHeaderIdentifier forIndexPath:indexPath];
        return headView;
    }
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        GZIMWorkspaceSectionFoot * footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:GZIMCollectionViewFooterIdentifier forIndexPath:indexPath];
        return footView;
    }
    
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(200, 68);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(200, 5);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GZIMWorkspaceItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GZWorkspaceItemReuseIdentifier forIndexPath:indexPath];
    
    cell.deleteDelegate = self;
//        UIColor * randomColor= [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
//        cell.backgroundColor = randomColor;
    [cell setItemText:self.departArry[indexPath.item]];
    
    return cell;
}
- (void)modelCellEvent:(GZIMWorkspaceItemCell *)cell {
    NSIndexPath * indexPath = [self.collectionView indexPathForCell:cell];
    [self.departArry removeObjectAtIndex:indexPath.row];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

/* 点击 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击>%@",self.departArry[indexPath.item]);
}

-(UICollectionViewFlowLayout *)collectionViewFlowLayout {
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 98);
    //定义每个UICollectionView 横向的间距(行间距)
    flowLayout.minimumLineSpacing = 10;
    //定义每个UICollectionView 纵向的间距（item与item之间距离）
    flowLayout.minimumInteritemSpacing = 0;
    //定义每个UICollectionView 的边距距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//上左下右
    return flowLayout;
}




#pragma mark - SETTER GETTER
-(NSMutableArray *)departArry {
    if (!_departArry) {
        _departArry = [NSMutableArray new];
    }
    return _departArry;
}
-(NSMutableArray *)roomArry {
    if (!_roomArry) {
        _roomArry = [NSMutableArray new];
    }
    return _roomArry;
}
-(NSMutableArray *)userArry {
    if (!_userArry) {
        _userArry = [NSMutableArray new];
    }
    return _userArry;
}
@end
