//
//  WKWebViewController.m
//  WKWebView
//
//  Created by zzg on 2018/12/21.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "FootNavigationView.h"
#import "SheetMoreView.h"

@interface WKWebViewController ()<SheetMoreDataSource>

@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) FootNavigationView * footView;

@property (nonatomic, strong) UIView * ControlView;


@property (nonatomic, strong) NSMutableArray * sheetShareData;

@end

@implementation WKWebViewController

-(NSMutableArray *)sheetShareData {
    if (!_sheetShareData) {
        _sheetShareData = [NSMutableArray new];
    }
    return _sheetShareData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"版本更新title";
    
    [self confgLeftBarButton];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.xypq.gov.cn/"]]];
    [self.view addSubview:self.webView];
    
    
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.view addSubview:self.progressView];
    
    self.footView = [[FootNavigationView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 56, self.view.frame.size.width, 56) forWKWebView:self.webView];
    self.footView.hidden = YES;
    [self.view addSubview:self.footView];
    
    
    
    SheetItem *gg = [SheetItem sheetItem:@"more_open_gg" forItemName:@"发送给呱呱同事"];
    SheetItem *wxFriend = [SheetItem sheetItem:@"more_open_wechat" forItemName:@"发送给微信好友"];
    SheetItem *wxTime = [SheetItem sheetItem:@"more_open_friend" forItemName:@"分享到朋友圈吧两行样式"];
    SheetItem *collection = [SheetItem sheetItem:@"more_open_collection" forItemName:@"收藏"];
    SheetItem *safari = [SheetItem sheetItem:@"more_open_safari" forItemName:@"在safari中打开"];
    SheetItem *copys = [SheetItem sheetItem:@"more_open_copy" forItemName:@"复制链接"];
    SheetItem *refresh = [SheetItem sheetItem:@"more_open_refresh" forItemName:@"刷新"];
    
    [self.sheetShareData addObject:gg];
    [self.sheetShareData addObject:wxFriend];
    [self.sheetShareData addObject:wxTime];
    [self.sheetShareData addObject:collection];
    [self.sheetShareData addObject:safari];
    [self.sheetShareData addObject:copys];
    [self.sheetShareData addObject:refresh];
}

/**
 设置返回按钮
 */
- (void)confgLeftBarButton {
    self.navigationItem.leftBarButtonItem = nil;
    UIButton * leftItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [leftItem setImage:[UIImage imageNamed:@"nav_close_icon"] forState:UIControlStateNormal];
    [leftItem setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [leftItem.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [leftItem addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:leftItem]];
    
    
    self.navigationItem.rightBarButtonItem = nil;
    UIButton * rightItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [rightItem setImage:[UIImage imageNamed:@"nav_more_icon"] forState:UIControlStateNormal];
    [rightItem setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightItem.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [rightItem addTarget:self action:@selector(showMoreView) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:rightItem]];
}

- (void)showMoreView {
    SheetMoreView * sheet = [[SheetMoreView alloc] initWithBottomTitle:@"取消"];
    sheet.dataSource = self;
    [sheet show];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.webView) {
        if ([keyPath isEqualToString:@"estimatedProgress"]) {
            CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
            if (newprogress == 1) {
                self.progressView.hidden = YES;
                [self.progressView setProgress:0 animated:NO];
            } else {
                self.progressView.hidden = NO;
                [self.progressView setProgress:newprogress animated:YES];
            }
        } else if ([keyPath isEqualToString:@"title"]) {
            self.title = self.webView.title;
        } else if([keyPath isEqualToString:@"canGoBack"]){
            self.footView.hidden = !self.webView.canGoBack;

            [self setFootNavgationState];
        } else if([keyPath isEqualToString:@"canGoForward"]){
            [self setFootNavgationState];
        } else {
            self.footView.hidden = YES;
        }
    }
}

- (void)setFootNavgationState {
    UIControlState goBackState = self.webView.canGoBack ? UIControlStateNormal : UIControlStateSelected;
    [self.footView setGoBackSelectState:goBackState];
    
    UIControlState goForWardState = self.webView.canGoForward ? UIControlStateNormal : UIControlStateSelected;
    [self.footView setForWardSelectState:goForWardState];
}


- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.height, 4)];
        _progressView.progressTintColor = [UIColor redColor];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.progress = 0.0f;
    }
    return _progressView;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(NSInteger)SheetShare:(SheetMoreView *)sheetShare numberOfItemsInSection:(NSInteger)section {
    return self.sheetShareData.count;
}

- (SheetItem *)SheetShare:(SheetMoreView *)sheetShare cellForIndexPath:(NSIndexPath *)indexPath {
    return self.sheetShareData[indexPath.row];
}



@end
