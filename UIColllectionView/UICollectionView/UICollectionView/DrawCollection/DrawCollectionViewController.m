//
//  DrawCollectionViewController.m
//  UICollectionView
//
//  Created by zzg on 2018/12/12.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "DrawCollectionViewController.h"
#import "ShufflingView.h"
#import "ShuffingFlowLayout.h"


@interface DrawCollectionViewController ()

@end

@implementation DrawCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ShuffingFlowLayout * flowLayout = [[ShuffingFlowLayout alloc] init];
    ShufflingView * cars = [[ShufflingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300) flowLayout:flowLayout];
    [self.view addSubview:cars];
}



@end
