//
//  MainViewController.m
//  rate-screen
//
//  Created by zzg on 2019/3/24.
//  Copyright © 2019 zzg. All rights reserved.
//

#import "MainViewController.h"
#import "VideoView.h"


@interface MainViewController ()


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    VideoView * vv = [[VideoView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [self.view addSubview:vv];
}


@end
