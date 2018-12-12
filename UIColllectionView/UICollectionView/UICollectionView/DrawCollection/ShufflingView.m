//
//  ShufflingView.m
//  UICollectionView
//
//  Created by zzg on 2018/12/12.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "ShufflingView.h"

@interface ShuffTempleteCell: UICollectionViewCell
@end

@implementation ShuffTempleteCell
@end



@interface ShufflingView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *carouselView;

@property (nonatomic, strong) NSMutableArray * arryData;

@end

@implementation ShufflingView



- (instancetype _Nullable )initWithFrame:(CGRect)frame
                              flowLayout:(nonnull ShuffingFlowLayout *)flowLayout {
    if(self = [super initWithFrame:frame]) {
        _flowLayout = flowLayout;
        [self configUI];
        self.backgroundColor = [UIColor grayColor];
        [self addSubview:self.carouselView];
    }
    return  self;
}
- (void)configUI {
    for (NSInteger index = 0; index < 10; index++) {
        [self.arryData addObject:[NSString stringWithFormat:@"%ld",index]];
    }
    
}



#pragma mark UICollectionViewDelegate  UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arryData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tempCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor blackColor];
    UILabel * label = [[UILabel alloc] initWithFrame:cell.contentView.frame];
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.arryData[indexPath.row];
//    [cell.contentView addSubview:label];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectItemAtIndexPathdidSelectItemAtIndexPath");
}


#pragma mark - < getter >
- (UICollectionView *)carouselView {
    if(!_carouselView) {
        _carouselView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200) collectionViewLayout:self.flowLayout];
        _carouselView.clipsToBounds = NO;
        _carouselView.delegate = self;
        _carouselView.dataSource = self;
        _carouselView.backgroundColor = [UIColor grayColor];
        _carouselView.showsVerticalScrollIndicator = NO;
        _carouselView.showsHorizontalScrollIndicator = NO;
//        _carouselView.decelerationRate = 0;
        [_carouselView registerClass:[ShuffTempleteCell class] forCellWithReuseIdentifier:@"tempCell"];
    }
    return _carouselView;
}


- (NSMutableArray *)arryData {
    if (!_arryData) {
        _arryData = [NSMutableArray new];
    }
    return _arryData;
}

@end
