//
//  iCloudManager.m
//  fileOpen
//
//  Created by zzg on 2018/11/6.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "iCloudManager.h"
#import "Document.h"

@implementation iCloudManager

+ (BOOL)iCloudEnable {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *url = [manager URLForUbiquityContainerIdentifier:nil];
    if (url != nil) {
        return YES;
    }
    NSLog(@"iCloud 不可用");
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"icloud" message:@"iCloud 不可用" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    return NO;
}

+ (void)downloadWithDocumentURL:(NSURL*)url callBack:(downloadBlock)block {
    Document *iCloudDoc = [[Document alloc]initWithFileURL:url];
    
    [iCloudDoc openWithCompletionHandler:^(BOOL success) {
        if (success) {
            
            [iCloudDoc closeWithCompletionHandler:^(BOOL success) {
                NSLog(@"关闭成功");
            }];
            
            if (block) {
                block(iCloudDoc.data);
            }
            
        }
    }];
}

@end
