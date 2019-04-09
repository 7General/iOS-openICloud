//
//  NSString+GZIMEncode.h
//  GZIMClient
//
//  Created by fangchenzhen on 2018/12/5.
//  Copyright © 2018 呱呱开放平台. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (GZIMEncode)

- (NSString*)encodeString;
- (NSString *)decodeString;

@end

NS_ASSUME_NONNULL_END
