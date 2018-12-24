//
//  ShareView.h
//  WKWebView
//
//  Created by zzg on 2018/12/22.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheetItem.h"

@class SheetMoreView;



@protocol SheetMoreDataSource <NSObject>

@required

- (NSInteger)SheetShare:(SheetMoreView *_Nullable)sheetShare numberOfItemsInSection:(NSInteger)section;

@optional
- (SheetItem *_Nullable)SheetShare:(SheetMoreView *_Nullable)sheetShare cellForIndexPath:(NSIndexPath *_Nullable)indexPath;
@end


@protocol SheetMoreDelegate <NSObject>
@optional
- (void)SheetShare:(SheetMoreView *_Nullable)sheetShare didSelectedIndexPath:(NSIndexPath *_Nullable)indexPath;
@end


@interface SheetMoreView : UIView

- (instancetype _Nullable )initWithBottomTitle:(NSString *_Nullable)title;
- (void)show;
-(void)dismisView;

@property (nonatomic, weak, nullable) id <SheetMoreDataSource> dataSource;
@property (nonatomic, weak, nullable) id <SheetMoreDelegate> delegate;

@end
