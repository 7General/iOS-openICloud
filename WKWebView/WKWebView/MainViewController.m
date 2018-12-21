//
//  MainViewController.m
//  WKWebView
//
//  Created by zzg on 2018/12/21.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "MainViewController.h"
#import "WKWebViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网页加壳";
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"加载网页" forState:0];
    [btn addTarget:self action:@selector(loadWebClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)loadWebClick {
    WKWebViewController * wk = [[WKWebViewController alloc] init];
    [self.navigationController pushViewController:wk animated:YES];
}

@end
