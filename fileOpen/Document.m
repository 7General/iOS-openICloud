//
//  Document.m
//  fileOpen
//
//  Created by zzg on 2018/11/6.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "Document.h"

@implementation Document
- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    
    self.data = contents;
    
    return YES;
}
@end
