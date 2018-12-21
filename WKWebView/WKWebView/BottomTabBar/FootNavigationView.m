//
//  BottomControlView.m
//  WKWebView
//
//  Created by zzg on 2018/12/21.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "FootNavigationView.h"


@interface FootNavigationView()
@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, weak) UIButton * backButton;
@property (nonatomic, weak) UIButton * forwardButton;
@end

@implementation FootNavigationView

- (instancetype)initWithFrame:(CGRect)frame forWKWebView:(WKWebView *)webView {
    self = [super initWithFrame:frame];
    if (self) {
        _webView = webView;
        [self configUI];
    }
    return self;
}




- (void)configUI {
    self.backgroundColor = [UIColor grayColor];
    
    CGFloat centerX = self.frame.size.width * 0.5;
    CGFloat centerY = self.frame.size.height * 0.5;
    
    /* 后退 */
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 10, 24);
    backButton.center = CGPointMake(centerX - 35, centerY);
    [backButton setImage:[UIImage imageNamed:@"foot_goback_normal"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"foot_goback_selected"] forState:UIControlStateSelected];
    [backButton addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    self.backButton = backButton;
    
    /* 前进 */
    UIButton * forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forwardButton.frame = CGRectMake(0, 0, 10, 24);
    forwardButton.center = CGPointMake(centerX + 35, centerY);
    [forwardButton setImage:[UIImage imageNamed:@"foot_forward_normal"] forState:UIControlStateNormal];
    [forwardButton setImage:[UIImage imageNamed:@"foot_forward_selected"] forState:UIControlStateSelected];
    [forwardButton addTarget:self action:@selector(goForWardClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:forwardButton];
    self.forwardButton = forwardButton;
}

- (void)goBackClick {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}
- (void)goForWardClick {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}

/**
 设置返回按钮的状态
 
 @param state UIControlState
 */
- (void)setGoBackSelectState:(UIControlState)state {
    if (state == UIControlStateSelected) {
        self.backButton.userInteractionEnabled = NO;
        self.backButton.selected = YES;
    } else {
        self.backButton.userInteractionEnabled = YES;
        self.backButton.selected = NO;
    }
}

/**
 设置向前按钮的状态
 
 @param state UIControlState
 */
- (void)setForWardSelectState:(UIControlState)state {
    if (state == UIControlStateSelected) {
        self.forwardButton.userInteractionEnabled = NO;
        self.forwardButton.selected = YES;
    } else {
        self.forwardButton.userInteractionEnabled = YES;
        self.forwardButton.selected = NO;
    }
}




@end
