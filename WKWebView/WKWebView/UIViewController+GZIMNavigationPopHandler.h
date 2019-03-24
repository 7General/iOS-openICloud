//
//  UIViewController+GZIMNavigationPopHandler.h
//  GZIMClient
//
//  Created by zhouxueyun on 2017/8/22.
//  Copyright © 2017年 呱呱开放平台. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GZIMNavigationPopHandlerDelegate <NSObject>

// 重写下面的方法以拦截NavigationPop事件，返回 YES 则 pop，NO 则不 pop
@optional
- (BOOL)navigationShouldPopOnBackButton;
- (BOOL)navigationShouldPopOnPopGesture;

- (BOOL)popGestureShouldBegin:(UIGestureRecognizer *)gesture;
- (BOOL)popGestureShouldRecognizeSimultaneouslyWithGesture:(UIGestureRecognizer *)otherGesture;
- (BOOL)popGestureShouldRequireFailureOfGesture:(UIGestureRecognizer *)otherGesture;
- (BOOL)popGestureShouldBeRequiredToFailByGesture:(UIGestureRecognizer *)otherGesture;

@end

@interface UIViewController (GZIMNavigationPopHandler) <GZIMNavigationPopHandlerDelegate>

@end

@interface UINavigationController (GZIMNavigationPopHandler) <UIGestureRecognizerDelegate>

- (void)initNavigationPopHandler;

@end
