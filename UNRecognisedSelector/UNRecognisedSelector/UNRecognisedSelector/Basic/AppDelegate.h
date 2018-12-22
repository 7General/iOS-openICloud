//
//  AppDelegate.h
//  UNRecognisedSelector
//
//  Created by zzg on 2018/12/22.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;



/*
 
 总结一下objc_msgSend会做一下几件事情：
 
 1:检查target是不是为nil。
    1.1:如果这里有相应的nil的处理函数，就跳转到相应的函数中。
    1.2如果没有处理nil的函数，就自动清理现场并返回。这一点就是为何在OC中给nil发送消息不会崩溃的原因。
 
 2:检测这个 selector是不是要忽略的。
 3:确定不是给nil发消息之后，objc_msgSend通过对象的isa指针获取到类的结构体，在该class的缓存中查找方法对应的IMP实现。如果找到，就跳转进去执行。如果没有找到，就在方法分发表里面继续查找。如果以上尝试都失败了，接下来就会循环尝试父类的缓存和方法列表，一直找到NSObject为止（因为NSObject的superclass为nil（还是它自己？），才跳出循环）。一旦定位到selector，函数会就获取到了实现的入口点，并传入相应的参数来执行方法的具体实现；如果最后没有定位到selector，则会走消息转发流程
 
 
 注：为了加速消息的处理，运行时系统缓存使用过的selector及对应的方法的地址。
 */


@end

