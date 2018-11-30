//
//  GZIMWorkspaceItemCell.m
//  UICollectionView
//
//  Created by zzg on 2018/11/13.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "GZIMWorkspaceItemCell.h"

@interface GZIMWorkspaceItemCell()
@property (nonatomic, weak) UILabel * itemName;

@property (nonatomic, weak) UIImageView * redPointView;
@end

@implementation GZIMWorkspaceItemCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI {
    UILabel * itemName = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width-20, self.frame.size.height-20)];
    itemName.textColor = [UIColor blackColor];
    itemName.font = [UIFont systemFontOfSize:16];
    itemName.textAlignment = NSTextAlignmentCenter;
    itemName.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:itemName];
    self.itemName = itemName;
    
//    UIImageView * redPointView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(itemName.frame) - 10, (itemName.frame.origin.y) - 10, 10, 10)];
//    redPointView.backgroundColor = [UIColor redColor];
//    redPointView.layer.cornerRadius = 5;
//    redPointView.layer.masksToBounds = YES;
//    [self.contentView addSubview:redPointView];
    
    UIButton * deletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deletBtn.frame = CGRectMake(10, 10, 20, 20);
    deletBtn.backgroundColor = [UIColor redColor];
    deletBtn.layer.cornerRadius = 10;
    deletBtn.layer.masksToBounds = YES;
    [deletBtn addTarget:self action:@selector(deleteCollectionFun) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:deletBtn];
}

- (void)deleteCollectionFun {
    if (self.deleteDelegate && [self.deleteDelegate respondsToSelector:@selector(modelCellEvent:)]) {
        [self.deleteDelegate modelCellEvent:self];
    }
}

- (void)setItemText:(NSString *)item {
    self.itemName.text = item;
    
//    UIColor * randomColor= [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
//
//    self.itemName.backgroundColor = randomColor;
}
- (void)setBackColor:(NSString *)item {
    if ([self.itemName.text isEqualToString:item]) {
        self.itemName.backgroundColor = [UIColor redColor];
    } else {
        self.itemName.backgroundColor = [UIColor whiteColor];
    }
}


@end
