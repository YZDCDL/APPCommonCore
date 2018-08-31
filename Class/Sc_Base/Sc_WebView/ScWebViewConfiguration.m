//
//  ScWebViewConfiguration.m
//  SCWCommonCore
//
//  Created by YinZhongDong on 2018/8/17.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#import "ScWebViewConfiguration.h"

@implementation ScWebViewConfiguration

+ (instancetype)defaultConfiguration{
    
    ScWebViewConfiguration *configuration = [[ScWebViewConfiguration alloc] init];
    // 1.允许视频播放
    if (@available(iOS 10.0, *)) {
        configuration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
    } else if (@available(iOS 9.0, *)){
        configuration.requiresUserActionForMediaPlayback = NO;
    } else {
        configuration.mediaPlaybackRequiresUserAction = NO;
    }
    
#ifdef __IPHONE_9_0
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_9_0) {
        configuration.allowsAirPlayForMediaPlayback = NO;
    }
#endif
    // 2.允许在线播放
    configuration.allowsInlineMediaPlayback = YES;
    // 3.允许可以与网页交互，选择视图
    configuration.selectionGranularity = YES;
    // 4.web内容处理池
    configuration.processPool = [[WKProcessPool alloc] init];
    // 5.自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
    
    // Source : https://stackoverflow.com/questions/26295277/wkwebview-equivalent-for-uiwebviews-scalespagetofit
    // 对应UIWebView的 ScaleToFit功能 适应设备
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *UserContentController = [[WKUserContentController alloc] init];
    [UserContentController addUserScript:wkUScript];
    
    // 6.添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
    //    [UserContentController addScriptMessageHandler:self name:@""];
    // 7.是否支持记忆读取
    configuration.suppressesIncrementalRendering = YES;
    // 8.允许用户更改网页的设置
    configuration.userContentController = UserContentController;
    
    return configuration;
}

@end
