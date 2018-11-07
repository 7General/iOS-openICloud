//
//  iCloudManager.h
//  fileOpen
//
//  Created by zzg on 2018/11/6.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^downloadBlock)(id obj);

@interface iCloudManager : NSObject

+ (BOOL)iCloudEnable;

+ (void)downloadWithDocumentURL:(NSURL*)url callBack:(downloadBlock)block;

@end
