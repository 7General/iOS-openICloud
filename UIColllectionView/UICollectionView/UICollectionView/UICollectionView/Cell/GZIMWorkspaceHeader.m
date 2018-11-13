//
//  GZIMWorkspaceHeader.m
//  UICollectionView
//
//  Created by zzg on 2018/11/13.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "GZIMWorkspaceHeader.h"

@implementation GZIMWorkspaceHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(12, 0, self.viewForLastBaselineLayout.frame.size.width - 24, 0.5)];
    [lineView setBackgroundColor:[UIColor redColor]];
    [self addSubview:lineView];
}
@end
