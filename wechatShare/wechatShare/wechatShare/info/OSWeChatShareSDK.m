//
//  wts.m
//  wechatShare
//
//  Created by zzg on 2018/12/10.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "OSWeChatShareSDK.h"
#import "WXApi.h"
#import "WXApiObject.h"


#define WS(weakSelf)  __weak __typeof(self) weakSelf = self;

@interface OSWeChatShareSDK()

@property (nonatomic, copy) void (^shareResult) (BOOL result);
@property (nonatomic, strong) NSString *weChatAppID;

@end

@implementation OSWeChatShareSDK


- (id)initWithShareID:(NSString *)shareID
{
    self = [super init];
    if (self) {
        self.weChatAppID = shareID;
        [self initWeiXinShareKit];
    }
    return self;
}

- (BOOL)isWechatOpenURL:(NSURL *)url
{
    if ([url.scheme isEqualToString:_weChatAppID]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)handleOpenUrl:(NSURL*)url
{
    if ([url.scheme isEqualToString:_weChatAppID]) {
        return [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
    }
    
    return NO;
}

+ (BOOL)canSupportShare
{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        return YES;
    }
    return NO;
}

- (void)initWeiXinShareKit
{
    WS(weakSelf);
    dispatch_async(dispatch_get_main_queue(), ^{
        [WXApi registerApp:weakSelf.weChatAppID];
    });
}

- (void)shareTextMessage:(NSString *)textMessage
               shareType:(GZWeChatShareType)shareType
             shareResult:(void(^)(BOOL result))shareResult
{
    //微信相关
    if (shareType == GZWeChatShareTypeFriend || shareType == GZWeChatShareTypeTimeline || shareType == GZWeChatShareTypeFavorite) {
        self.shareResult = shareResult;
        NSInteger scene = WXSceneSession;
        if (shareType == GZWeChatShareTypeTimeline) {
            scene = WXSceneTimeline;
        }
        if (shareType == GZWeChatShareTypeFavorite) {
            scene = WXSceneFavorite;
        }
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.text = textMessage;
        req.bText = YES;
        req.scene = scene;
        [WXApi sendReq:req];
    }
}

- (void)shareMediaMessageWithTitle:(NSString *)title
                       description:(NSString *)description
                        thumbImage:(UIImage *)thumbImage
                          shareURL:(NSString *)shareURL
                         shareType:(GZWeChatShareType)shareType
                       shareResult:(void(^)(BOOL result))shareResult
{
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = shareURL;
    
    if (shareType == GZWeChatShareTypeFriend || shareType == GZWeChatShareTypeTimeline || shareType == GZWeChatShareTypeFavorite) {
        self.shareResult = shareResult;
        NSInteger scene = WXSceneSession;
        if (shareType == GZWeChatShareTypeTimeline) {
            scene = WXSceneTimeline;
        }
        if (shareType == GZWeChatShareTypeFavorite) {
            scene = WXSceneFavorite;
        }
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title?:@"";
        message.description = description?:@"";
        [message setThumbImage:thumbImage];
        message.mediaObject = ext;
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = scene;
        [WXApi sendReq:req];
    }
}

#pragma mark -微信回调
//微信回调
- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]]) {
        //支付回调
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
            case WXSuccess: {
                
            }
                break;
            case WXErrCodeUserCancel:
            {
                //用户取消
                
            }
                break;
            default:
                break;
        }
    } else {
        if (resp.errCode == WXSuccess) {
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
}


@end
