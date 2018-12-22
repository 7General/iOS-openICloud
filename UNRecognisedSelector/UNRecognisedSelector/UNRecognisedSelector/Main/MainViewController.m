//
//  MainViewController.m
//  UNRecognisedSelector
//
//  Created by zzg on 2018/12/22.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "MainViewController.h"
#import "Father.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    Father * father = [[Father alloc] init];
    [father derveCar];
}


@end
