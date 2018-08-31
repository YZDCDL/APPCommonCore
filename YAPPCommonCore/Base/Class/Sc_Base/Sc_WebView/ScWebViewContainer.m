//
//  ScWebviewContainer.m
//  SCWCommonCore
//
//  Created by YinZhongDong on 2018/8/17.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#import "ScWebViewContainer.h"
#import "NSString+ScWebView.h"

static NSString *const LOADING_KEYPATH  = @"loading";
static NSString *const TITLE_KEYPATH    = @"title";
static NSString *const PROGR_KEYPATH    = @"estimatedProgress";

@interface ScWebViewContainer ()
@property (nonatomic,strong) WKWebViewConfiguration *configuration;

@end

@implementation ScWebViewContainer
#pragma mark - overwrite
- (instancetype)init{
    self = [super init];
    if (self) {
        // 设置
        [self setupConfig];
        // 添加监听
        [self addKVO];
    }
    return self;
}

#pragma mark - private methods
- (void)setupConfig {
    // 1.设置WKUIDelegate
    self.webView.UIDelegate = self;
    // 2.设置WKNavigationDelegate
    self.webView.navigationDelegate = self;
    // 3.设置允许滑动返回手势，default is NO
    self.webView.allowsBackForwardNavigationGestures = YES;
}

- (void)addKVO {
    
    [self.webView addObserver:self
                   forKeyPath:PROGR_KEYPATH
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
    [self.webView addObserver:self
                   forKeyPath:TITLE_KEYPATH
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
    [self.webView addObserver:self
                   forKeyPath:LOADING_KEYPATH
                      options:NSKeyValueObservingOptionNew
                      context:nil];
}

#pragma mark - system methods
- (void)setupViews{
    [self addSubview:self.webView];
    [self addSubview:self.progressView];
}

- (void)updateConstraints{
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(2.5);
    }];
    
    [super updateConstraints];
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:TITLE_KEYPATH];
    [self.webView removeObserver:self forKeyPath:PROGR_KEYPATH];
    [self.webView removeObserver:self forKeyPath:LOADING_KEYPATH];
}


#pragma mark - lazy load

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.trackTintColor = [UIColor whiteColor];
        _progressView.progressTintColor = [UIColor redColor];
    }
    return _progressView;
}

- (WKWebView *)webView{
    
    if (!_webView) {
        if (self.isConfig && self.defaultConfiguration){
            _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.configuration];
        }else{
            ScWebViewConfiguration * configuration = [ScWebViewConfiguration defaultConfiguration];
            _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        }
    }
    return _webView;
}

- (void)setTransparentBackground:(BOOL)transparentBackground{
    _transparentBackground = transparentBackground;
    if (transparentBackground) {
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.opaque = NO;
    } else {
        self.webView.backgroundColor = nil;
        self.webView.opaque = YES;
    }
}

#pragma mark - kvo监听事件
- (void)observeValueForKeyPath:(nullable NSString *)keyPath
                      ofObject:(nullable id)object
                        change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(nullable void *)context {
    
    // title发生改变
    if ([keyPath isEqualToString:TITLE_KEYPATH]) {
        NSString *changeValue = (NSString *)change[NSKeyValueChangeNewKey];
        if (self.webViewTitleChangeBlock) {
            self.webViewTitleChangeBlock(changeValue);
        }
    }
    // progress发生改变
    if ([keyPath isEqualToString:PROGR_KEYPATH]) {
        //estimatedProgress取值范围是0-1;
        self.progressView.progress = self.webView.estimatedProgress;
    }
    // 是否在加载
    if (self.webView.loading) {
        self.progressView.alpha = 1;
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.progressView.alpha = 0;
        }];
    }
}


#pragma mark - Public Methed
// 加载URL
- (void)loadUrlString:(NSString *)url {
    NSAssert(url, @"URL can not be nil");
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]
                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval:30];
    [self.webView loadRequest:request];
}

//  加载本地html
- (void)loadLocalHtmlWithName:(NSString *)htmlName {
    
    NSURL *htmlPath = [[NSBundle mainBundle] URLForResource:htmlName withExtension:@"html"];
    NSString *contentString = [[NSString alloc] initWithContentsOfURL:htmlPath
                                                             encoding:NSUTF8StringEncoding
                                                                error:nil];
    [self.webView loadHTMLString:contentString baseURL:[[NSBundle mainBundle] bundleURL]];
}



#pragma mark - WKNavigationDelegate
//  Web内容开始在网页视图中加载时调用。
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    if (self.webViewStartLoadBlock) {
        self.webViewStartLoadBlock(webView);
    }
}

//  当Web视图加载内容时发生错误时调用。
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if (self.webViewLoadErrorBlock) {
        self.webViewLoadErrorBlock(webView, error);
    }
    
    // 加载出错时 修改Title [webView.title isValid] ? webView.title :
    
    NSString *title =  @"页面加载失败";
    if (self.webViewTitleChangeBlock) {
        self.webViewTitleChangeBlock(title);
    }
}

//  导航完成后调用。
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    if (self.webViewFinishLoadBlock) {
        self.webViewFinishLoadBlock(webView);
    }
    
    // 加载完毕时 修改Title
    NSString *title = webView.title;//[webView.title isValid] ? webView.title : Sc_BundleInfoPlist[@"CFBundleDisplayName"];
    if (self.webViewTitleChangeBlock) {
        self.webViewTitleChangeBlock(title);
    }
}



//  当Web视图收到服务器重定向时调用。
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = navigationAction.request.URL;
    
    
    // 1.阻止加载“空”页面
    if ([url.absoluteString isEqualToString:@"about:blank"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    // 2.补充添加 “打电话” “发短信” “发邮件功能”
    NSArray *funsArray = @[@"tel" ,@"sms" ,@"mailto"];
    if ([funsArray containsObject:url.scheme])
    {
        if ([application canOpenURL:url])
        {
            [application openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    
    // 3.Url重定向的target
    if (!navigationAction.targetFrame) {
        if ([application canOpenURL:url]) {
            [application openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    
    // 4.跳转appstroe
    NSString *urlString = (url) ? url.absoluteString : @"";
    if ([urlString ex_isiTunesURL]) {
        [application openURL:url];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    // 5.执行Block
    if (self.webViewUrlRouteBlock) {
        self.webViewUrlRouteBlock(navigationAction, decisionHandler);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    self.webViewAuthBlock?self.webViewAuthBlock(webView ,challenge ,completionHandler):completionHandler(NSURLSessionAuthChallengePerformDefaultHandling ,nil);
}

#pragma mark - WKUIDelegate
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    
    //  创建一个新的网页视图。
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    //  显示一个JavaScript警报面板。
//    [EXAlert AlertOneWithTitle:@"提示" message:message];
    completionHandler();
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    
    //  显示一个JavaScript确认面板。
//    [EXAlert AlertTwoWithTitle:@"提示" message:message doneButtonTitle:@"确认" dontButtonBlock:^{
//        completionHandler(YES);
//    } cancelButtonTitle:@"取消" cancelButtonBlock:^{
//        completionHandler(NO);
//    }];
//
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler {
    
    //  显示一个JavaScript文本输入面板。
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:prompt
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alterController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder =defaultText;
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@""
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             completionHandler(nil);
                                                         }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@""
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              completionHandler(@"");
                                                          }];
    
    [alterController addAction:cancelAction];
    [alterController addAction:confirmAction];
    
//    [[UIViewController currentViewController] presentViewController:alterController animated:YES completion:nil];
}

@end
