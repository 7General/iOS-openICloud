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
}

- (void)setItemText:(NSString *)item {
    self.itemName.text = item;
}

@end
