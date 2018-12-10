//
//  微信朋友圈 OSQQShareSDK.h
//  wechatShare
//
//  Created by zzg on 2018/12/10.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    OSQQShareQType,   //微信聊天界面
    OSQQShareQZoneType    //微信朋友圈
} OSQQShareType;



@interface OSQQShareSDK : NSObject


- (id)initWithShareID:(NSString *)shareID;

- (BOOL)isQQOpenURL:(NSURL *)url;

- (BOOL)handleOpenUrl:(NSURL*)url;

+ (BOOL)canSupportShare;

- (void)shareTextMessage:(NSString *)textMessage
               shareType:(OSQQShareType)shareType
             shareResult:(void(^)(BOOL result))shareResult;

- (void)shareMediaMessageWithTitle:(NSString *)title
                       description:(NSString *)description
                        thumbImage:(UIImage *)thumbImage
                          shareURL:(NSString *)shareURL
                         shareType:(OSQQShareType)shareType
                       shareResult:(void(^)(BOOL result))shareResult;


@end
