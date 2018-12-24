//
//  SheetItemCell.m
//  WKWebView
//
//  Created by zzg on 2018/12/22.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "GZIMSheetOpenCell.h"
#import "GZIMSheetOpenEntity.h"

@interface GZIMSheetOpenCell()

@property (nonatomic, weak) UILabel * itemLabel;
@property (nonatomic, weak) UIImageView * corverImageView;

@end

@implementation GZIMSheetOpenCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    CGFloat itemWidth = self.frame.size.width;
    UIImageView * corverImageView = [[UIImageView alloc] initWithFrame:CGRectMake((itemWidth - 60) * 0.5, 0, 60, 60)];
    [self.contentView addSubview:corverImageView];
    self.corverImageView = corverImageView;
    
    
    UILabel * itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(corverImageView.frame) + 5, self.frame.size.width, 25)];
    itemLabel.textColor = [UIColor colorWithRed:51/255.0 green:59/255.0 blue:65/255.0 alpha:1/1.0];
    itemLabel.font = [UIFont systemFontOfSize:10];
    itemLabel.numberOfLines = 0;
    itemLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:itemLabel];
    self.itemLabel = itemLabel;
}


- (void)setItemText:(GZIMSheetOpenEntity *)item {
    self.corverImageView.image = [UIImage imageNamed:item.itemIcon];
    [self.itemLabel setText:item.itemName];
}

@end
