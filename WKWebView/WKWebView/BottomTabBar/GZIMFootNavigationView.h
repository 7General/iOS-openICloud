//
//  BottomControlView.h
//  WKWebView
//
//  Created by zzg on 2018/12/21.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface FootNavigationView : UIView


- (instancetype)initWithFrame:(CGRect)frame forWKWebView:(WKWebView *)webView;

/**
 设置向前按钮的状态

 @param state UIControlState
 */
- (void)setForWardSelectState:(UIControlState)state;

/**
 设置返回按钮的状态
 
 @param state UIControlState
 */
- (void)setGoBackSelectState:(UIControlState)state;

- (void)dismiss;
- (void)show;

@end
