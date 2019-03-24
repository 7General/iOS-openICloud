//
//  WKWebViewController.m
//  WKWebView
//
//  Created by zzg on 2018/12/21.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "GZIMFootNavigationView.h"
#import "GZIMSheetOpenEntity.h"
#import "GZIMSheetOpenView.h"
#import "UIViewController+GZIMNavigationPopHandler.h"

@interface WKWebViewController ()<GZIMSheetOpenViewDataSource,GZIMSheetOpenViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) FootNavigationView * footView;

@property (nonatomic, strong) UIView * ControlView;


@property (nonatomic,strong) id popDelegate;


@property (nonatomic, strong) NSMutableArray * sheetShareData;
@property (nonatomic, assign) CGFloat  lastContentOffset;

@end

@implementation WKWebViewController

-(NSMutableArray *)sheetShareData {
    if (!_sheetShareData) {
        _sheetShareData = [NSMutableArray new];
    }
    return _sheetShareData;
}
-(BOOL)navigationShouldPopOnBackButton {
    if (self.webView.canGoBack) {
        [self.webView goBack];
        return NO;
    }
    return YES;
}

- (BOOL)navigationShouldPopOnPopGesture {
    if (self.webView.canGoBack) {
        return NO;
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"版本更新title";
    
    [self confgLeftBarButton];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.xypq.gov.cn/"]]];
//    self.webView.UIDelegate = self;
//    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    
    self.webView.scrollView.delegate = self;
    [self.view addSubview:self.progressView];
    
    self.footView = [[FootNavigationView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 56, self.view.frame.size.width, 56) forWKWebView:self.webView];
    self.footView.hidden = YES;
    [self.view addSubview:self.footView];
    
    
    
    GZIMSheetOpenEntity *gg = [GZIMSheetOpenEntity sheetItem:@"more_open_gg" forItemName:@"发送给呱呱同事" forShareType:GZIMShareGUAGUA];
    GZIMSheetOpenEntity *wxFriend = [GZIMSheetOpenEntity sheetItem:@"more_open_wechat" forItemName:@"发送给微信好友" forShareType:GZIMShareWeChatFriend];
    GZIMSheetOpenEntity *wxTime = [GZIMSheetOpenEntity sheetItem:@"more_open_friend" forItemName:@"分享到朋友圈吧两行样式" forShareType:GZIMShareWeChatTime];
    GZIMSheetOpenEntity *collection = [GZIMSheetOpenEntity sheetItem:@"more_open_collection" forItemName:@"收藏" forShareType:GZIMShareCollection];
    GZIMSheetOpenEntity *safari = [GZIMSheetOpenEntity sheetItem:@"more_open_safari" forItemName:@"在safari中打开" forShareType:GZIMShareSafari];
    GZIMSheetOpenEntity *copys = [GZIMSheetOpenEntity sheetItem:@"more_open_copy" forItemName:@"复制链接" forShareType:GZIMShareCopyUrl];
    GZIMSheetOpenEntity *refresh = [GZIMSheetOpenEntity sheetItem:@"more_open_refresh" forItemName:@"刷新" forShareType:GZIMShareRefresh];
    
    [self.sheetShareData addObject:gg];
    [self.sheetShareData addObject:wxFriend];
    [self.sheetShareData addObject:wxTime];
    [self.sheetShareData addObject:collection];
    [self.sheetShareData addObject:safari];
    [self.sheetShareData addObject:copys];
    [self.sheetShareData addObject:refresh];
}

//- (void)popViewController {
//    [self.navigationController popViewControllerAnimated:YES];
//}

/**
 设置返回按钮
 */
- (void)confgLeftBarButton {
//    self.navigationItem.leftBarButtonItem = nil;
//    UIButton * leftItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
//    [leftItem setImage:[UIImage imageNamed:@"nav_close_icon"] forState:UIControlStateNormal];
//    [leftItem setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [leftItem.titleLabel setFont:[UIFont systemFontOfSize:17]];
//    [leftItem addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:leftItem]];
    
    
    self.navigationItem.rightBarButtonItem = nil;
    UIButton * rightItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [rightItem setImage:[UIImage imageNamed:@"nav_more_icon"] forState:UIControlStateNormal];
    [rightItem setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightItem.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [rightItem addTarget:self action:@selector(showMoreView) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:rightItem]];
}

- (void)showMoreView {
    GZIMSheetOpenView * sheet = [[GZIMSheetOpenView alloc] initWithBottomTitle:@"取消"];
    sheet.dataSource = self;
    sheet.delegate = self;
    [sheet show];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"=====%@",keyPath);
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

-(NSInteger)SheetShare:(GZIMSheetOpenView *)sheetShare numberOfItemsInSection:(NSInteger)section {
    return self.sheetShareData.count;
}

- (GZIMSheetOpenEntity *)SheetShare:(GZIMSheetOpenView *)sheetShare cellForIndexPath:(NSIndexPath *)indexPath {
    return self.sheetShareData[indexPath.row];
}

- (void)SheetShare:(GZIMSheetOpenView *)sheetShare didSelectedIndexPath:(NSIndexPath *)indexPath {
    GZIMSheetOpenEntity * item = self.sheetShareData[indexPath.row];
    NSLog(@"---->>>>didSelectIndexPath:%@",item.itemName);
}


//实现scrollView代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.lastContentOffset = scrollView.contentOffset.y;//判断上下滑动时
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < self.lastContentOffset ){
        //向上
        [self.footView show];
    } else if (scrollView.contentOffset.y > self.lastContentOffset ){
        //向下
        [self.footView dismiss];
    }
}



//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    NSLog(@"===>>>>:%@",[webView.URL absoluteString]);
//}
//-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//
//}
//
//-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//
//}
//
//- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
//    WKFrameInfo *frameInfo = navigationAction.targetFrame;
//    if (![frameInfo isMainFrame]) {
//        [self.webView loadRequest:navigationAction.request];
//    }
//    return nil;
//}





@end

