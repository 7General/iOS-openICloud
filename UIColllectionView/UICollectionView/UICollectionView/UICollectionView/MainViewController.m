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

@interface MainViewController ()

@property (nonatomic, strong) NSMutableArray * departArry;
@property (nonatomic, strong) NSMutableArray * roomArry;
@property (nonatomic, strong) NSMutableArray * userArry;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addData];
    
    
    self.collectionView.contentInset = UIEdgeInsetsMake(50 + 20, 0, 0, 0);
    /* 注册header和foot */
    [self.collectionView registerClass:[GZIMWorkspaceHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GZIMCollectionViewHeaderIdentifier];
    [self.collectionView registerClass:[GZIMWorkspaceSectionFoot class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GZIMCollectionViewFooterIdentifier];
    
    [self.collectionView registerClass:[GZIMWorkspaceItemCell class] forCellWithReuseIdentifier:GZWorkspaceItemReuseIdentifier];
}
- (void)addData {
    [self.departArry addObject:@"12"];
    [self.departArry addObject:@"11"];
    [self.departArry addObject:@"13"];
    [self.departArry addObject:@"14"];
    [self.departArry addObject:@"15"];
    [self.departArry addObject:@"16"];
    [self.departArry addObject:@"17"];
    
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
    return   3;
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
        UIColor * randomColor= [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        cell.backgroundColor = randomColor;
    return cell;
}

/* 点击 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击");
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
