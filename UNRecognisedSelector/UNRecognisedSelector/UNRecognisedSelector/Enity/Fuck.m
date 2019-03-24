//
//  Fuck.m
//  UNRecognisedSelector
//
//  Created by zzg on 2018/12/26.
//  Copyright © 2018 zzg. All rights reserved.
//

#import "Fuck.h"
#import <objc/runtime.h>

void smartFunction()
{
    //return 0;
    NSLog(@"asssss");
}


@implementation Fuck
-(void)fos {
    NSLog(@"-------fuck");
}
- (BOOL)addFunc:(SEL)sel {
  return  class_addMethod([Fuck class], sel, (IMP)smartFunction, "v@:");
    
}
@end
