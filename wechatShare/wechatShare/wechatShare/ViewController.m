//
//  ViewController.m
//  wechatShare
//
//  Created by zzg on 2018/12/10.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "ViewController.h"
#import "OSShareHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"-=---");
    /* 微信 */
//    [[OSShareHelper shareInstance] shareTextMessage:@"ddddd" shareType:(OSShareTypeWXFriend) shareResult:^(BOOL result) {
//        NSLog(@"resoult");
//    }];
    
    /* QQ */
    [[OSShareHelper shareInstance] shareMediaMessageWithTitle:@"QQ分享" description:@"SQQQQ" thumbImage:nil shareURL:@"http://www.osjoin.com" shareType:OSShareTypeQQShare shareResult:^(BOOL result) {
        NSLog(@"resoult,www.osjoin.com");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
