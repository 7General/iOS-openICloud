//
//  OSShareHelper.m
//  wechatShare
//
//  Created by zzg on 2018/12/10.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "OSShareHelper.h"
#import "OSWeChatShareSDK.h"
#import "OSQQShareSDK.h"

@interface OSShareHelper()
@property (nonatomic, strong) OSWeChatShareSDK * wechatShare;
@property (nonatomic, strong) OSQQShareSDK * qqShare;

@property (nonatomic, strong) NSString *qqAppID;
@property (nonatomic, strong) NSString *weiBoAppKey;
@property (nonatomic, strong) NSString *weChatAppID;
@end

@implementation OSShareHelper

static OSShareHelper *osHelper = nil;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        osHelper = [[OSShareHelper alloc] init];
    });
    return osHelper;
}


- (void)setShareSDKKeysWithQQID:(NSString *)qqID wechatID:(NSString *)wechatID weiBoID:(NSString *)weiBoID {
    if (wechatID) {
        self.wechatShare = [[OSWeChatShareSDK alloc] initWithShareID:wechatID];
    }
    if (qqID) {
        self.qqShare = [[OSQQShareSDK alloc] initWithShareID:qqID];
    }
}

+ (BOOL)isShareOpenURL:(NSURL *)url {
    BOOL isOpenURL = NO;
//    isOpenURL = [self..weiBoShareKit isWeiBoOpenURL:url];
//    if (isOpenURL) {
//        return YES;
//    }
    isOpenURL = [osHelper.wechatShare isWechatOpenURL:url];
    if (isOpenURL) {
        return YES;
    }
    isOpenURL = [osHelper.qqShare isQQOpenURL:url];
    if (isOpenURL) {
        return YES;
    }
    return NO;
}
+ (BOOL)canSupportShare:(OSShareType)shareType {
    if (shareType == OSShareTypeWXFriend || shareType == OSShareTypeWXTimeline || shareType == OSShareTypeWXFavorite) {
        return [OSWeChatShareSDK canSupportShare];
    }
//    if (shareType == GZShareTypeWBShare) {
//        return [GZWeiBoShareSDK canSupportShare];
//    }
    if (shareType == OSShareTypeQQShare || shareType == OSShareTypeQQZoneShare) {
        return [OSQQShareSDK canSupportShare];
    }
    return NO;
}

- (BOOL)handleOpenUrl:(NSURL *)url {
    if ([self.wechatShare isWechatOpenURL:url]) {
        return [self.wechatShare handleOpenUrl:url];
    } else if ([self.qqShare isQQOpenURL:url]) {
        return [self.qqShare handleOpenUrl:url];
    }
    return NO;
}


- (void)shareTextMessage:(NSString *)textMessage shareType:(OSShareType)shareType shareResult:(void(^)(BOOL result))shareResult {
    if (shareType == OSShareTypeWXFriend || shareType == OSShareTypeWXTimeline || shareType == OSShareTypeWXFavorite) {
        [self.wechatShare shareTextMessage:textMessage shareType:(GZWeChatShareType)shareType shareResult:shareResult];
    }
}

- (void)shareMediaMessageWithTitle:(NSString *)title
                       description:(NSString *)description
                        thumbImage:(UIImage *)thumbImage
                          shareURL:(NSString *)shareURL
                         shareType:(OSShareType)shareType
                       shareResult:(void(^)(BOOL result))shareResult {
    if (shareType == OSShareTypeWXFriend || shareType == OSShareTypeWXTimeline || shareType == OSShareTypeWXFavorite) {
        [self.wechatShare shareMediaMessageWithTitle:title description:description thumbImage:thumbImage shareURL:shareURL shareType:(GZWeChatShareType)shareType shareResult:shareResult];
    }
    //else if (shareType == GZShareTypeWBShare) {
        //[_weiBoShareKit shareMediaMessageWithTitle:title description:description thumbImage:thumbImage shareURL:shareURL shareResult:shareResult];
    //}
    else if (shareType == OSShareTypeQQShare || shareType == OSShareTypeQQZoneShare) {
        OSQQShareType qqShareT = OSQQShareQType;
        if (shareType == OSShareTypeQQZoneShare) {
            qqShareT = OSQQShareQZoneType;
        }
        [self.qqShare shareMediaMessageWithTitle:title description:description thumbImage:thumbImage shareURL:shareURL shareType:qqShareT shareResult:shareResult];
    }
}
@end
