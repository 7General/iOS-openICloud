//
//  GZIMWorkspaceItemCell.h
//  UICollectionView
//
//  Created by zzg on 2018/11/13.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GZIMWorkspaceItemCell;

@protocol CustomCollectionViewDelete <NSObject>
@optional
- (void)modelCellEvent:(GZIMWorkspaceItemCell *)cell;
@end

@interface GZIMWorkspaceItemCell : UICollectionViewCell

- (void)setItemText:(NSString *)item;

- (void)setBackColor:(NSString *)item;

@property (nonatomic, weak) id<CustomCollectionViewDelete> deleteDelegate;
@end
