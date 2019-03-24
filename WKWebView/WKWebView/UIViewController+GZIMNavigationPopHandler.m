//
//  UIViewController+BackButtonHandler.m
//  GZIMClient
//
//  Created by zhouxueyun on 2017/8/22.
//  Copyright © 2017年 呱呱开放平台. All rights reserved.
//

#import "UIViewController+GZIMNavigationPopHandler.h"

@implementation UIViewController (GZIMNavigationPopHandler)

@end

@implementation UINavigationController (GZIMNavigationPopHandler)

- (void)initNavigationPopHandler
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        __weak __typeof(self) weakSelf = self;
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isEqual:self.interactivePopGestureRecognizer]) {
        if ([self.viewControllers count] <= 1) {
            return NO;
        }
        UIViewController *viewController = [self topViewController];
        if ([viewController respondsToSelector:@selector(navigationShouldPopOnPopGesture)]) {
            BOOL shouldPop = [viewController navigationShouldPopOnPopGesture];
//            XLOG_DEBUG(@"navigationShouldPopOnPopGesture return %@", shouldPop?@"YES":@"NO");
            return shouldPop;
        } else if ([viewController respondsToSelector:@selector(popGestureShouldBegin:)]) {
            BOOL shouldPop = [viewController popGestureShouldBegin:gestureRecognizer];
//            XLOG_DEBUG(@"popGestureShouldBegin return %@", shouldPop?@"YES":@"NO");
            return shouldPop;
        }
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isEqual:self.interactivePopGestureRecognizer]) {
        if ([self.viewControllers count] <= 1) {
            return NO;
        }
        UIViewController *viewController = [self topViewController];
        if ([viewController respondsToSelector:@selector(popGestureShouldRequireFailureOfGesture:)]) {
            BOOL should = [viewController popGestureShouldRequireFailureOfGesture:otherGestureRecognizer];
//            XLOG_DEBUG(@"popGestureShouldRequireFailureOfGesture return %@", should?@"YES":@"NO");
            return should;
        }
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isEqual:self.interactivePopGestureRecognizer]) {
        if ([self.viewControllers count] <= 1) {
            return NO;
        }
        UIViewController *viewController = [self topViewController];
        if ([viewController respondsToSelector:@selector(popGestureShouldBeRequiredToFailByGesture:)]) {
            BOOL should = [viewController popGestureShouldBeRequiredToFailByGesture:otherGestureRecognizer];
//            XLOG_DEBUG(@"popGestureShouldBeRequiredToFailByGesture return %@", should?@"YES":@"NO");
            return should;
        }
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isEqual:self.interactivePopGestureRecognizer]) {
        if ([self.viewControllers count] <= 1) {
            return NO;
        }
        UIViewController *viewController = [self topViewController];
        if ([viewController respondsToSelector:@selector(popGestureShouldRecognizeSimultaneouslyWithGesture:)]) {
            BOOL should = [viewController popGestureShouldRecognizeSimultaneouslyWithGesture:otherGestureRecognizer];
//            XLOG_DEBUG(@"popGestureShouldRecognizeSimultaneouslyWithGesture return %@", should?@"YES":@"NO");
            return should;
        }
    }
    return NO;
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController *viewController = [self topViewController];
    if([viewController respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [viewController navigationShouldPopOnBackButton];
//        XLOG_DEBUG(@"navigationShouldPopOnBackButton return %@", shouldPop?@"YES":@"NO");
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
        
    } else {
        // 取消 pop 后，复原返回按钮的状态
        for(UIView *subview in [navigationBar subviews]) {
            if(0 < subview.alpha && subview.alpha < 1) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1;
                }];
            }
        }
    }
    return NO;
}

@end
