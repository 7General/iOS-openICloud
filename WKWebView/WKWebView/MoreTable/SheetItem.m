//
//  SheetItem.m
//  WKWebView
//
//  Created by zzg on 2018/12/22.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "SheetItem.h"

@implementation SheetItem
- (instancetype)initItem:(NSString *)itemIcon forItemName:(NSString *)itemName {
    self = [super init];
    if (self) {
        self.itemIcon = itemIcon;
        self.itemName = itemName;
    }
    return self;
}


+ (instancetype)sheetItem:(NSString *)itemIcon forItemName:(NSString *)itemName {
    return [[self alloc] initItem:itemIcon forItemName:itemName];
}

@end
