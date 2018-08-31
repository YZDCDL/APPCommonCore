//
//  UINavigationBar+WRAddition.h
//  StoryBoardDemo
//
//  Created by wangrui on 2017/4/9.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRNavigationBar

#import <UIKit/UIKit.h>

#pragma mark - UINavigationBar
@interface UINavigationBar (WRAddition) <UINavigationBarDelegate>

/** 设置导航栏所有BarButtonItem的透明度 */
- (void)wr_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/** 设置导航栏在垂直方向上平移多少距离 */
- (void)wr_setTranslationY:(CGFloat)translationY;

/** 获取当前导航栏在垂直方向上偏移了多少 */
- (CGFloat)wr_getTranslationY;

@end




#pragma mark - UIViewController
@interface UIViewController (WRAddition)

/** record current ViewController navigationBar backgroundImage **/
- (void)wr_setNavBarBackgroundImage:(UIImage *)image;

/** record current ViewController navigationBar barTintColor */
- (void)wr_setNavBarBarTintColor:(UIColor *)color;

/** record current ViewController navigationBar backgroundAlpha */
- (void)wr_setNavBarBackgroundAlpha:(CGFloat)alpha;

/** record current ViewController navigationBar tintColor */
- (void)wr_setNavBarTintColor:(UIColor *)color;

/** record current ViewController titleColor */
- (void)wr_setNavBarTitleColor:(UIColor *)color;

/** record current ViewController statusBarStyle */
- (void)wr_setStatusBarStyle:(UIStatusBarStyle)style;
- (UIStatusBarStyle)wr_statusBarStyle;

/** record current ViewController navigationBar shadowImage hidden */
- (void)wr_setNavBarShadowImageHidden:(BOOL)hidden;
- (BOOL)wr_navBarShadowImageHidden;

/** record current ViewController custom navigationBar */
- (void)wr_setCustomNavBar:(UINavigationBar *)navBar;

@end






