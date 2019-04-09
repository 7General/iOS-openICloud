//
//  ViewController.m
//  UIScrollViewScrollTop
//
//  Created by zzg on 2019/3/29.
//  Copyright © 2019 zzg. All rights reserved.
//

#import "ViewController.h"
#import "NSString+GZIMEncode.h"
#import <WebKit/WebKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getCoupon)];
    [view addGestureRecognizer:tap];
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    scrollView.backgroundColor = [UIColor greenColor];
    scrollView.contentSize = CGSizeMake(0, 200);
    scrollView.userInteractionEnabled = NO;
    [view addSubview:scrollView];
    
    //    NSString * urls = @"https://sta.guazi.com/we_client/c2c-common.html#appraisal?city_name=北京&ca_n=ios&plate_time[year]=2014&domain=bj&road_haul=12&city_domain=bj&ca_s=app_self&plate_time[month]=1&city_id=12";

    NSString * urls = @"https://sta.guazi.com/we_client/c2c-common.html#appraisal?city_name=%e5%8c%97%e4%ba%ac&ca_n=ios&plate_time[year]=2014&domain=bj&road_haul=12&city_domain=bj&ca_s=app_self&plate_time[month]=1&city_id=12";
//    NSString * str = @"https://www.baidu.com/s?wd=你好";
//    NSURL * url = [NSURL URLWithString:[urls stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    
//    NSString * urlss = [urls encodeString];

//    NSURL * url = [NSURL URLWithString:urls];
    NSLog(@"=====");
    
    
//    NSMutableCharacterSet *lastSet = [[NSMutableCharacterSet alloc] init];
//                                                                                                          // (CFStringRef)@"!*'();:@&=+$,/?%#[]",
//    [lastSet formUnionWithCharacterSet:[NSCharacterSet characterSetWithCharactersInString:@"-_.!~*;/?:@&=+$,#"]];
//    [lastSet formUnionWithCharacterSet:[NSCharacterSet letterCharacterSet]];
//    [lastSet formUnionWithCharacterSet:[NSCharacterSet alphanumericCharacterSet]];
//    urls = [urls stringByAddingPercentEncodingWithAllowedCharacters:lastSet];
    
    
    //stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding
    
    
    WKWebView * wek = [[WKWebView alloc] initWithFrame:CGRectMake(100, 100, 400, 400)];
   urls = [urls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urls]];
    NSLog(@"%@  \n %@", urls, request);
    [wek loadRequest:request];
    [self.view addSubview:wek];
    
    
   
    
    
}
- (void)getCoupon {
    NSLog(@"===================");
}


@end
