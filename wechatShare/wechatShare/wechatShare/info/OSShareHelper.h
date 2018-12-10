//
//  OSShareHelper.h
//  wechatShare
//
//  Created by zzg on 2018/12/10.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    OSShareTypeWXFriend,
    OSShareTypeWXTimeline,
    OSShareTypeWXFavorite,
    OSShareTypeWBShare,       //微博分享
    OSShareTypeQQShare,       //QQ分享
    OSShareTypeQQZoneShare    //QQ空间分享
    
} OSShareType;


@interface OSShareHelper : NSObject

+ (instancetype)shareInstance;

- (void)setShareSDKKeysWithQQID:(NSString *)qqID wechatID:(NSString *)wechatID weiBoID:(NSString *)weiBoID;

+ (BOOL)isShareOpenURL:(NSURL *)url;

- (BOOL)handleOpenUrl:(NSURL *)url;

+ (BOOL)canSupportShare:(OSShareType)shareType;

- (void)shareTextMessage:(NSString *)textMessage shareType:(OSShareType)shareType shareResult:(void(^)(BOOL result))shareResult;

- (void)shareMediaMessageWithTitle:(NSString *)title
                       description:(NSString *)description
                        thumbImage:(UIImage *)thumbImage
                          shareURL:(NSString *)shareURL
                         shareType:(OSShareType)shareType
                       shareResult:(void(^)(BOOL result))shareResult;

@end
