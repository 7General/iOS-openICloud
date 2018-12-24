//
//  ShareView.h
//  WKWebView
//
//  Created by zzg on 2018/12/22.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZIMSheetOpenEntity.h"

@class GZIMSheetOpenView;



@protocol GZIMSheetOpenViewDataSource <NSObject>

@required

- (NSInteger)SheetShare:(GZIMSheetOpenView *_Nullable)sheetShare numberOfItemsInSection:(NSInteger)section;

@optional
- (GZIMSheetOpenEntity *_Nullable)SheetShare:(GZIMSheetOpenView *_Nullable)sheetShare cellForIndexPath:(NSIndexPath *_Nullable)indexPath;
@end


@protocol GZIMSheetOpenViewDelegate <NSObject>
@optional
- (void)SheetShare:(GZIMSheetOpenView *_Nullable)sheetShare didSelectedIndexPath:(NSIndexPath *_Nullable)indexPath;
@end


@interface GZIMSheetOpenView : UIView

- (instancetype _Nullable )initWithBottomTitle:(NSString *_Nullable)title;
- (void)show;
-(void)dismisView;

@property (nonatomic, weak, nullable) id <GZIMSheetOpenViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id <GZIMSheetOpenViewDelegate> delegate;

@end
