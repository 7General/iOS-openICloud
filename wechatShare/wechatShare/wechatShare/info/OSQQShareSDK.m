//
//  微信朋友圈 OSQQShareSDK.m
//  wechatShare
//
//  Created by zzg on 2018/12/10.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "OSQQShareSDK.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>

@interface OSQQShareSDK()

@property (nonatomic, copy) void (^shareResult) (BOOL result);
@property (nonatomic, strong) NSString *qqAppID;

@end

@implementation OSQQShareSDK

- (id)initWithShareID:(NSString *)shareID
{
    self = [super init];
    if (self) {
        self.qqAppID = shareID;
        TencentOAuth *oauth = [[TencentOAuth alloc] initWithAppId:_qqAppID
                                                      andDelegate:(id<TencentSessionDelegate>)self];
        if (!oauth) {
            //注册失败
        }
    }
    return self;
}

- (BOOL)isQQOpenURL:(NSURL *)url
{
    NSString *qqAppKey = [NSString stringWithFormat:@"tencent%@", _qqAppID];
    if ([url.scheme isEqualToString:qqAppKey]) {
        return YES;
    }
    return NO;
}

- (BOOL)handleOpenUrl:(NSURL*)url
{
    NSString *qqAppKey = [NSString stringWithFormat:@"tencent%@", _qqAppID];
    if ([url.scheme isEqualToString:qqAppKey]) {
        return [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)self];
    }
    return NO;
}

+ (BOOL)canSupportShare
{
    if ([QQApiInterface isQQSupportApi]) {
        return YES;
    }
    return NO;
}

- (void)shareTextMessage:(NSString *)textMessage
               shareType:(OSQQShareType)shareType
             shareResult:(void(^)(BOOL result))shareResult
{
    
}

- (void)shareMediaMessageWithTitle:(NSString *)title
                       description:(NSString *)description
                        thumbImage:(UIImage *)thumbImage
                          shareURL:(NSString *)shareURL
                         shareType:(OSQQShareType)shareType
                       shareResult:(void(^)(BOOL result))shareResult
{
    self.shareResult = shareResult;
    
    NSData *data;
    data = UIImageJPEGRepresentation(thumbImage, 0.5);
    QQApiURLObject *newsObj = [QQApiURLObject objectWithURL:[NSURL URLWithString:shareURL] title:title description:description previewImageData:data targetContentType:QQApiURLTargetTypeNews];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    
    QQApiSendResultCode sent = EQQAPISENDSUCESS;
    if (shareType == OSQQShareQType) {
        //将内容分享到qq
        sent = [QQApiInterface sendReq:req];
    }
    if (shareType == OSQQShareQZoneType) {
        //将内容分享到qzone
        sent = [QQApiInterface SendReqToQZone:req];
    }
    
    if (sent != EQQAPISENDSUCESS) {
        NSLog(@"分享失败");
    }
    
}

#pragma mark -QQ回调
- (void)onResp:(QQBaseResp *)resp
{
    if (resp.type == ESENDMESSAGETOQQRESPTYPE) {
        if (_shareResult) {
            _shareResult(1);
            self.shareResult = nil;
        }
    }else{
        if (_shareResult) {
            _shareResult(0);
            self.shareResult = nil;
        }
    }
}

@end
