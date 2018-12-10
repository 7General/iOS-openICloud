//
//  wts.h
//  wechatShare
//
//  Created by zzg on 2018/12/10.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    GZWeChatShareTypeFriend,   //微信聊天界面
    GZWeChatShareTypeTimeline, //微信朋友圈
    GZWeChatShareTypeFavorite  //微信收藏
} GZWeChatShareType;

@interface OSWeChatShareSDK : NSObject


- (id)initWithShareID:(NSString *)shareID;


- (BOOL)isWechatOpenURL:(NSURL *)url;


- (BOOL)handleOpenUrl:(NSURL*)url;


+ (BOOL)canSupportShare;


- (void)shareTextMessage:(NSString *)textMessage
               shareType:(GZWeChatShareType)shareType
             shareResult:(void(^)(BOOL result))shareResult;


- (void)shareMediaMessageWithTitle:(NSString *)title
                       description:(NSString *)description
                        thumbImage:(UIImage *)thumbImage
                          shareURL:(NSString *)shareURL
                         shareType:(GZWeChatShareType)shareType
                       shareResult:(void(^)(BOOL result))shareResult;


@end
