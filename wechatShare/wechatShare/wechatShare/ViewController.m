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
//    [[OSShareHelper shareInstance] shareTextMessage:@"爱我中华" shareType:(OSShareTypeWXFriend) shareResult:^(BOOL result) {
//        NSLog(@"resoult");
//    }];
    
    /* QQ */
    
    [[OSShareHelper shareInstance] shareMediaMessageWithTitle:@"QQ分享" description:@"中国虎东北浪" thumbImage:[UIImage imageNamed:@"123"] shareURL:@"http://www.osjoin.com/ios/70.html" shareType:OSShareTypeWXFriend shareResult:^(BOOL result) {
        NSLog(@"resoult,www.osjoin.com");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
