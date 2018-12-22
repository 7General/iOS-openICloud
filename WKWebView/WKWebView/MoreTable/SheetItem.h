//
//  SheetItem.h
//  WKWebView
//
//  Created by zzg on 2018/12/22.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SheetItem : NSObject

@property (nonatomic, strong) NSString * itemIcon;
@property (nonatomic, strong) NSString * itemName;

+ (instancetype)sheetItem:(NSString *)itemIcon forItemName:(NSString *)itemName;
@end
