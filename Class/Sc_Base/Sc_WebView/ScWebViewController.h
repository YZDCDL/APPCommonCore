//
//  ScWebViewController.h
//  SCWCommonCore
//
//  Created by YinZhongDong on 2018/8/17.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//



#import "ScViewController.h"
#import "ScWebViewConfiguration.h"
#import "ScWebViewContainer.h"


@interface ScWebViewController : ScViewController
/**
 3选1
 */
@property (nonatomic,copy) NSString *urlStr;
@property (nonatomic,copy) NSString *htmlName;
@property (strong ,nonatomic) NSURLRequest *request;

@property (nonatomic,assign) BOOL *isConfig;
@property (nonatomic,strong) WKWebViewConfiguration *defaultConfiguration;

@property (nonatomic,strong) ScWebViewContainer * webView;

@property (nonatomic,strong) UIButton *closeButton;
@end
