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


@protocol CustomDatePickerDelegate <NSObject>
@optional

- (void)CpickerView:(nullable UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end


@interface SheetMoreView : UIView

- (instancetype _Nullable )initWithBottomTitle:(NSString *_Nullable)title;
- (void)show;
-(void)dismisView;

@property (nonatomic, weak, nullable) id <SheetMoreDataSource> dataSource;

@end
