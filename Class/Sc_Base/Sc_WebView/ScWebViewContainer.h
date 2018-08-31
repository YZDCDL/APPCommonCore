//
//  ScWebviewContainer.h
//  SCWCommonCore
//
//  Created by YinZhongDong on 2018/8/17.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//


#import "ScWebViewConfiguration.h"
#import "ScView.h"

typedef void (^webViewTitleChangeBlock)(NSString *title);
typedef void (^webViewLoadProgressBlock)(double newValue);
typedef void (^webViewIsLoadingBlock)(void);

typedef void (^webViewStartLoadBlock)(WKWebView *webView);
typedef void (^webViewFinishLoadBlock)(WKWebView *webView);
typedef void (^webViewLoadErrorBlock)(WKWebView *webView, NSError *error);

typedef void (^webViewUrlRouteBlock)(WKNavigationAction *navigationAction ,void (^decisionHandler)(WKNavigationActionPolicy));

typedef void(^webViewReceiveAuthenticationChallengeBlock)(WKWebView *webView ,NSURLAuthenticationChallenge *challenge ,void (^completionHandler)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential));


@interface ScWebViewContainer : ScView <WKUIDelegate,WKNavigationDelegate>
// 0.基础组件
@property (nonatomic,strong) WKWebView *webView;

/**
 用于让EXWebViewController持有iCQJSBridge的实例
 
 * Example:
 * iCQJSBridge *bridge = [[iCQJSBridge alloc] initWithWebView:VC.webView.webView];
 * VC.jsBridgeHandler = bridge;
 */
@property (strong,nonatomic) NSObject *jsBridgeHandler;

@property (nonatomic,strong) UIProgressView *progressView;
@property (nonatomic,assign,getter=isTransparentBackground) BOOL transparentBackground;

@property (nonatomic,assign) BOOL *isConfig;
@property (nonatomic,strong) WKWebViewConfiguration *defaultConfiguration;

// 2.title发生变化执行的block
@property (copy, nonatomic) webViewTitleChangeBlock webViewTitleChangeBlock;
// 3.加载进度的block
@property (copy, nonatomic) webViewLoadProgressBlock webViewLoadProgressBlock;
// 4.webView是否在加载
@property (copy, nonatomic) webViewIsLoadingBlock webViewIsLoadingBlock;

// 5.Web内容开始在网页视图中加载时调用的Block
@property (copy, nonatomic) webViewStartLoadBlock webViewStartLoadBlock;
// 6.导航完成后调用的Block
@property (copy, nonatomic) webViewFinishLoadBlock webViewFinishLoadBlock;
// 7.当Web视图加载内容时发生错误时调用的Block
@property (copy, nonatomic) webViewLoadErrorBlock webViewLoadErrorBlock;

// 8.当Web视图收到服务器重定向时调用的Block
@property (copy, nonatomic) webViewUrlRouteBlock webViewUrlRouteBlock;

@property (copy ,nonatomic) webViewReceiveAuthenticationChallengeBlock webViewAuthBlock;

/* 9.加载链接
 *  @param  url 链接地址
 */
- (void)loadUrlString:(NSString *)url;
/* 9.加载本地网页
 *  @param  htmlName html文件名
 */
- (void)loadLocalHtmlWithName:(NSString *)htmlName;

@end
