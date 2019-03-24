//
//  Father.m
//  UNRecognisedSelector
//
//  Created by zzg on 2018/12/22.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "Father.h"
#import "Son.h"

@implementation Father

- (void)derveCar {
    Son * s = [[Son alloc] init];
    // 默认Son，没有实现run方法，可以通过performSelector调用，但是会报错。
    // 动态添加方法就不会报错
//    [s performSelector:@selector(drivePlan)];
    [s performSelector:@selector(runS)];
}

@end
