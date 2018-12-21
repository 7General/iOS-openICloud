//
//  WKWebViewController.m
//  WKWebView
//
//  Created by zzg on 2018/12/21.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
//#import "BottomControlView.h"
#import "FootNavigationView.h"

@interface WKWebViewController ()

@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, strong) UIProgressView *progressView;
//@property (nonatomic, strong) BottomControlView * bottmControlView;
@property (nonatomic, strong) FootNavigationView * footView;

@property (nonatomic, strong) UIView * ControlView;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"版本更新title";
    
    [self confgLeftBarButton];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.xypq.gov.cn/"]]];
    [self.view addSubview:self.webView];
    
    
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.view addSubview:self.progressView];
    
    self.footView = [[FootNavigationView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 56, self.view.frame.size.width, 56) forWKWebView:self.webView];
    self.footView.hidden = YES;
    [self.view addSubview:self.footView];
}

/**
 设置返回按钮
 */
- (void)confgLeftBarButton {
    self.navigationItem.leftBarButtonItem = nil;
    UIButton * leftItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [leftItem setImage:[UIImage imageNamed:@"nav_close_icon"] forState:UIControlStateNormal];
    [leftItem setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [leftItem.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [leftItem addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:leftItem]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.webView) {
        if ([keyPath isEqualToString:@"estimatedProgress"]) {
            CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
            if (newprogress == 1) {
                self.progressView.hidden = YES;
                [self.progressView setProgress:0 animated:NO];
            }else {
                self.progressView.hidden = NO;
                [self.progressView setProgress:newprogress animated:YES];
            }
        } else if ([keyPath isEqualToString:@"title"]) {
            self.title = self.webView.title;
        } else if([keyPath isEqualToString:@"canGoBack"]){
            self.footView.hidden = !self.webView.canGoBack;
            if (self.webView.canGoBack) {
                [self.footView setGoBackSelectState:UIControlStateNormal];
            } else {
                [self.footView setGoBackSelectState:UIControlStateSelected];
            }
            
            if (self.webView.canGoForward) {
                [self.footView setForWardSelectState:UIControlStateNormal];
            } else {
                [self.footView setForWardSelectState:UIControlStateSelected];
            }
            
        } else if([keyPath isEqualToString:@"canGoForward"]){
            if (self.webView.canGoForward) {
                [self.footView setForWardSelectState:UIControlStateNormal];
            } else {
                [self.footView setForWardSelectState:UIControlStateSelected];
            }
            
            if (self.webView.canGoBack) {
                [self.footView setGoBackSelectState:UIControlStateNormal];
            } else {
                [self.footView setGoBackSelectState:UIControlStateSelected];
            }
        } else {
            self.footView.hidden = YES;
        }
    }
}


- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.height, 4)];
        _progressView.progressTintColor = [UIColor redColor];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.progress = 0.0f;
    }
    return _progressView;
}



@end
