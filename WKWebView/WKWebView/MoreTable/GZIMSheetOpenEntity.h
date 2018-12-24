//
//  SheetItem.h
//  WKWebView
//
//  Created by zzg on 2018/12/22.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    GZIMShareGUAGUA, // 发送给呱呱同事
    GZIMShareWeChatFriend, // 发送给微信好友
    GZIMShareWeChatTime, // 分享到微信朋友圈
    GZIMShareCollection, // 收藏
    GZIMShareSafari, // 在Safari中打开
    GZIMShareCopyUrl, // 复制链接
    GZIMShareRefresh, // 刷新
} GZIMShareMoreType;

@interface GZIMSheetOpenEntity : NSObject

@property (nonatomic, strong) NSString * itemIcon;
@property (nonatomic, strong) NSString * itemName;
@property (nonatomic, assign) GZIMShareMoreType  shareType;

+ (instancetype)sheetItem:(NSString *)itemIcon forItemName:(NSString *)itemName forShareType:(GZIMShareMoreType)shareType;
@end
