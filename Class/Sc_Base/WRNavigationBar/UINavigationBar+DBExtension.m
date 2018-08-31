//
//  UINavigationBar+DBExtension.m
//  EXCommonCore
//
//  Created by Xu Mengtong on 22/9/17.
//  Copyright © 2017年 Earth. All rights reserved.
//

#import "UINavigationBar+DBExtension.h"
#import <objc/runtime.h>

@interface UINavigationBar ()

@property (strong ,nonatomic) UIImageView *db_backgroundView;

@end

@implementation UINavigationBar (DBExtension)

- (UIImageView *)db_backgroundView {
    UIImageView *backgroundView = objc_getAssociatedObject(self, _cmd);
    if (!backgroundView) {
        backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))]; // + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;  // ****
        // _UIBarBackground is first subView for navigationBar
        /** iOS11下导航栏不显示问题 */
        if (self.subviews.count > 0) {
            [self.subviews.firstObject insertSubview:backgroundView atIndex:0];
        } else {
            [self insertSubview:backgroundView atIndex:0];
        }
        
        // 赋值
        self.db_backgroundView = backgroundView;
    }
    return backgroundView;
}

- (void)setDb_backgroundView:(UIImageView *)db_backgroundView {
    objc_setAssociatedObject(self, @selector(db_backgroundView), db_backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// -> 设置导航栏背景图片
- (void)db_setBackgroundImage:(UIImage *)image {
    // add a image(nil color) to _UIBarBackground make it clear
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    self.db_backgroundView.image = image;
    self.db_backgroundView.backgroundColor = nil;
}

// -> 设置导航栏背景颜色
- (void)db_setBackgroundColor:(UIColor *)color {
    // add a image(nil color) to _UIBarBackground make it clear
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    self.db_backgroundView.image = nil;
    self.db_backgroundView.backgroundColor = color;
}

#pragma mark - public method -------
/** 设置当前 NavigationBar 背景透明度*/
- (void)db_setBackgroundAlpha:(CGFloat)alpha {
    UIView *barBackgroundView = self.subviews.firstObject;
    barBackgroundView.alpha = alpha;
    
    if (@available(iOS 11.0, *)) {  // iOS11 下 UIBarBackground -> UIView/UIImageViwe
        for (UIView *view in self.subviews) {
            if ([NSStringFromClass([view class]) containsString:@"UIbarBackGround"]) {
                view.alpha = 0;
            }
        }
        // iOS 下如果不设置 UIBarBackground 下的UIView的透明度，会显示不正常
        if (barBackgroundView.subviews.firstObject) {
            barBackgroundView.subviews.firstObject.alpha = alpha;
        }
    }
}

/** 设置导航栏所有 barButtonItem 的透明度*/
- (void)db_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator {
    for (UIView *view in self.subviews) {
        if (hasSystemBackIndicator == YES) {
            // _UIBarBackground/_UINavigationBarBackground对应的view是系统导航栏，不需要改变其透明度
            Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
            if (_UIBarBackgroundClass != nil) {
                if (![view isKindOfClass:_UIBarBackgroundClass]) {
                    view.alpha = alpha;
                }
            }
            Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
            if (_UINavigationBarBackground != nil) {
                if (![view isKindOfClass:_UINavigationBarBackground]) {
                    view.alpha = alpha;
                }
            }
        } else {
            // 这里如果不做判断的话，会显示 backIndicatorImage
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")] == NO) {
                Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
                if (_UIBarBackgroundClass != nil) {
                    if (![view isKindOfClass:_UIBarBackgroundClass]) {
                        view.alpha = alpha;
                    }
                }
                Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
                if (_UINavigationBarBackground != nil) {
                    if (![view isKindOfClass:_UINavigationBarBackground]) {
                        view.alpha = alpha;
                    }
                }
            }
        }
    }
}

/** 设置当前 NavigationBar 垂直方向上的平移距离*/
- (void)db_setTranslationY:(CGFloat)translationY {
    // CGAffineTransformMakeTranslation  平移
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}
- (CGFloat)db_getTranslationY {
    return self.transform.ty;
}

@end

@implementation UIImage (DBNavigationBarExtension)

+ (UIImage *)_db_imageWithColor:(UIColor *)color alpha:(CGFloat)alpha {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextSetAlpha(context, alpha);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end

