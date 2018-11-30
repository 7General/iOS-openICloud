//
//  CWCarousel.h
//  CWCarousel
//
//  Created by WangChen on 2018/4/3.
//  Copyright © 2018年 ChenWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZIMCarouselProtocol.h"
#import "GZIMFlowLayout.h"

@interface GZIMCarousel : UIView
#pragma mark - < 相关属性 >

/**
 控件版本号
 */
@property (nonatomic, readonly, copy) NSString                  * _Nonnull version;


/**
 相关代理
 */
@property (nonatomic, assign) id <GZIMCarouselDelegate> _Nullable delegate;


/**
 相关数据源
 */
@property (nonatomic, assign) id <GZIMCarouselDatasource> _Nullable datasource;


/**
 布局自定义layout
 */
@property (nonatomic, strong, readonly) GZIMFlowLayout    * _Nonnull flowLayout;


/**
 样式风格
 */
@property (nonatomic, assign, readonly) GZIMCarouselStyle   style;


/**
 style = CWCarouselStyle_H_3时的扩展高度 (1.1.0版本后该属性废弃,请不要使用了)
 */
@property (nonatomic, assign, readonly) CGFloat           addHeight;


/**
 实际的示轮播图内容的视图(其实就是基于collectionView实现的)
 */
@property (nonatomic, strong, readonly) UICollectionView  * _Nonnull carouselView;


/**
 是否自动轮播, 默认为NO
 */
@property (nonatomic, assign) BOOL                        isAuto;


/**
 自动轮播时间间隔, 默认 3s
 */
@property (nonatomic, assign) NSTimeInterval              autoTimInterval;


/**
 默认的pageControl
 1. 默认在水平居中正下方
 2. 位置可以自己根据frame自行调整
 3. 如果不想将其添加在carousel上,请自行通过调用目标父视图的addSubview方法添加到其他父视图上
 */
@property (nonatomic, strong) UIPageControl               *pageControl;


/**
 自定义的pageControl
 */
@property (nonatomic, strong) UIView<GZIMCarouselPageControlProtocol> *customPageControl;


/**
 是否开始无限轮播
 YES: 可以无限衔接
 NO: 滑动到第一张或者最后一张就不能滑动了
 */
@property (nonatomic, assign) BOOL                        endless;
#pragma mark - < 相关方法 >
/**
 创建实例构造方法

 @param frame 尺寸大小
 @param delegate 代理
 @param datasource 数据源
 @param flowLayout 自定义flowlayout
 @return 实例对象
 */
- (instancetype _Nullable )initWithFrame:(CGRect)frame
                        delegate:(id<GZIMCarouselDelegate> _Nullable)delegate
                        datasource:(id<GZIMCarouselDatasource> _Nullable)datasource
                       flowLayout:(nonnull GZIMFlowLayout *)flowLayout;

/**
 注册自定视图

 @param viewClass 自定义视图类名
 @param identifier 重用唯一标识符
 */
- (void)registerViewClass:(Class _Nullable )viewClass identifier:(NSString *_Nullable)identifier;

/**
 注册自定义视图

 @param nibName 自定义视图xib相关文件名
 @param identifier 重用唯一标识符
 */
- (void)registerNibView:(NSString *_Nullable)nibName identifier:(NSString *_Nullable)identifier;


/**
 刷新轮播图
 */
- (void)freshCarousel;

/**
 暂停轮播图后,可以调用改方法继续播放
 */
- (void)resumePlay;

/**
 轮播图暂停自动播放
 */
- (void)pause;

/**
 如果开启自动轮播,销毁前需要调用该方法,释放定时器.否则可能内存泄漏
 */
- (void)releaseTimer;

/**
 轮播图所处控制器WillAppear方法里调用
 */
- (void)controllerWillAppear;

/**
 轮播图所处控制器WillDisAppear方法里调用
 */
- (void)controllerWillDisAppear;
@end
