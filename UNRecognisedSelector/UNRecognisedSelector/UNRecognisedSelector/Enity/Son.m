//
//  Son.m
//  UNRecognisedSelector
//
//  Created by zzg on 2018/12/22.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "Son.h"
#import <objc/runtime.h>

#import "Fuck.h"

/**
 1****:https://www.jianshu.com/p/3a30d5fb2db3?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
 2****:https://www.jianshu.com/p/60c251712df7
 3****:https://www.jianshu.com/p/d072bfbe1a60
 */

@implementation Son

// 默认方法都有两个隐式参数，
void testRun(id self,SEL sel) {
    [[Son new]  drivePlan];
    NSLog(@"son is drivePlan");
}

- (void)drivePlan {
    NSLog(@"Son>>>>drivePlan");
}

/**************
**  1.0  动态方法解析
**************/
// 当一个对象调用未实现的方法，会调用这个方法处理,并且会把对应的方法列表传过来.
// 刚好可以用来判断，未实现的方法是不是我们想要动态添加的方法
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    NSLog(@"\n\n\n\n---====>>>resolveInstanceMethod");
////    //判断方法是否是run
////    if ([NSStringFromSelector(sel) isEqualToString:@"runS"]) {
////        // 动态添加run方法
////
////        // 第一个参数：给哪个类添加方法
////        // 第二个参数：添加方法的方法编号
////        // 第三个参数：添加方法的函数实现（函数地址）
////        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
////        class_addMethod([self class], sel, (IMP)testRun, "v@:@");
////        return YES;
////    }
//    return [super resolveInstanceMethod:sel];
//}

/*
 如果也没有找到IMP的实现,resloveInstanceMethod:返回NO之后，就会进入消息转发阶段。
 */

/**************
 ** 2.0 消息转发阶段
 **************/
//********* 如果在上一步无法处理消息，则runtime会继续调用以下方法(不重写上一步方法)
/*
 -forwardindTargetWithSelctor:方法。在这个方法中，返回的对象就是message的接收者，然后会回到resloveInstanceMethod方法，从新开始消息转发过程，如果返回nil则会进入下一个方法中（-forwardInvocation）去判断是否响应这个消息。
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    BOOL isForward = [self respondsToSelector:aSelector];
    NSMethodSignature * signature = [self methodSignatureForSelector:aSelector];
    if (isForward || signature) {
        return [super forwardingTargetForSelector:aSelector];
    } else {
        Fuck * f = [[Fuck alloc] init];
        [f addFunc:aSelector];
        return f;
    }
    
}
@end
