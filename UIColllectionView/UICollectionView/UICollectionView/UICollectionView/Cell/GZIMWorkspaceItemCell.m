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
    UILabel * itemName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    itemName.textColor = [UIColor blackColor];
    itemName.font = [UIFont systemFontOfSize:16];
    itemName.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:itemName];
    self.itemName = itemName;
    
    UIImageView * redPointView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(itemName.frame) - 10, (itemName.frame.origin.y) - 10, 10, 10)];
    redPointView.backgroundColor = [UIColor redColor];
    redPointView.layer.cornerRadius = 5;
    redPointView.layer.masksToBounds = YES;
    [self.contentView addSubview:redPointView];
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
