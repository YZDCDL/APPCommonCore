//
//  ScWebViewController.m
//  SCWCommonCore
//
//  Created by YinZhongDong on 2018/8/17.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#import "ScWebViewController.h"
#import <Masonry/Masonry.h>
#import "NSString+ScCategory.h"

NSString *const EXWebViewReloadNotification = @"EXWebViewReloadNotification";

@interface ScWebViewController ()

@end

@implementation ScWebViewController

#pragma mark - system method;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"加载中..";
}

- (void)addSubViews{
    [self.view addSubview:self.webView];
}

- (void)updateViewConstraints{
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iCCNavigationHeight);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [super updateViewConstraints];
}

- (void)layoutNavigation{
    WEAKSELF;
    
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:self.closeButton];
    
    UIBarButtonItem *gapItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    gapItem.width = 10;
    
    UIBarButtonItem *backItem = self.ex_navigationItem.leftBarButtonItem;
    self.ex_popBlock = ^{
        weakSelf.webView.webView.canGoBack ? weakSelf.webView.webView.goBack : [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    self.ex_navigationItem.leftBarButtonItems = @[backItem ,gapItem ,closeItem];
}

- (void)bindViewModel{
    [self.webView.webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        NSString *userAgent = [NSString stringWithFormat:@"%@ %@/V%@",result ,@"wxcitycq", Sc_Bundle_ShortVersion];
        if (@available(iOS 9.0, *)) {
            self.webView.webView.customUserAgent = userAgent;
        } else {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":userAgent}];
            });
        }
    }];
    
    WEAKSELF;
    
//    // 0.非法执行
//    if ([self.urlStr isBlank] && [self.htmlName isBlank])
//        return;
//
    // 1.加载url 和 htmlName
    if ([self.urlStr isValidUrl]) {
        [self.webView loadUrlString:self.urlStr];
    }else if ([self.htmlName isValid]){
        [self.webView loadLocalHtmlWithName:self.htmlName];
    } else if (self.request) {
        [self.webView.webView loadRequest:self.request];
    }
    
    // 2.更改title
    self.webView.webViewTitleChangeBlock = ^(NSString *title) {
        weakSelf.title = title;
    };
    
    // 3.展示工具栏
    // todo
}

#pragma mark - private methods
- (void)registerForNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(webViewReloadNotificationAction:)
                                                 name:EXWebViewReloadNotification
                                               object:nil];
}

- (void)webViewReloadNotificationAction:(NSNotification *)notification {
    [self.webView.webView reload];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DLog(@"%s",__FUNCTION__);
}

#pragma mark - lazy load
- (ScWebViewContainer *)webView{
    if (!_webView) {
        if (self.isConfig && self.defaultConfiguration){
            _webView.isConfig = self.isConfig;
            _webView.defaultConfiguration = self.defaultConfiguration;
        }
        _webView = [[ScWebViewContainer alloc] init];
        
    }
    return _webView;
}

- (UIButton *)closeButton{
//    WEAKSELF;
    
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        _closeButton.frame = CGRectMake(0, 0, 37, 30);
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        _closeButton.titleLabel.font = H15;
        [_closeButton setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [_closeButton setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateHighlighted];
        _closeButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0); // 这里微调返回键的位置
        [_closeButton addTarget:self action:@selector(closeWebViewController) forControlEvents:UIControlEventTouchUpInside];
//        [_closeButton setHandleEventBlock:^(UIButton *sender){
//            weakSelf.presentingViewController ? [weakSelf dismissViewControllerAnimated:YES completion:nil] : [weakSelf.navigationController popViewControllerAnimated:YES];
//        }];
    }
    
    return _closeButton;
    
}

- (void)closeWebViewController{
     self.presentingViewController ? [self dismissViewControllerAnimated:YES completion:nil] : [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
