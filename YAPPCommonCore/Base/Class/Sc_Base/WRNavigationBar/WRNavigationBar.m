#import "WRNavigationBar.h"
#import <objc/runtime.h>
#import "UINavigationBar+DBExtension.h"

@implementation UINavigationBar (WRAddition)

- (void)wr_setBackgroundImage:(UIImage *)image {
    [self db_setBackgroundImage:image];
}

- (void)wr_setBackgroundColor:(UIColor *)color {
    [self db_setBackgroundColor:color];
}

- (void)wr_setBackgroundAlpha:(CGFloat)alpha {
    [self db_setBackgroundAlpha:alpha];
}

// 设置导航栏在垂直方向上平移多少距离
- (void)wr_setTranslationY:(CGFloat)translationY {
    [self db_setTranslationY:translationY];
}

/** 获取当前导航栏在垂直方向上偏移了多少 */
- (CGFloat)wr_getTranslationY {
    return [self db_getTranslationY];
}

/** 设置导航栏所有BarButtonItem的透明度 */
- (void)wr_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator{
    [self db_setBarButtonItemsAlpha:alpha hasSystemBackIndicator:hasSystemBackIndicator];
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        SEL needSwizzleSelectors[1] = {
            @selector(setTitleTextAttributes:)
        };
      
        for (int i = 0; i < 1;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [NSString stringWithFormat:@"wr_%@", NSStringFromSelector(selector)];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)wr_setTitleTextAttributes:(NSDictionary<NSString *,id> *)titleTextAttributes {
    NSMutableDictionary<NSString *,id> *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    if (newTitleTextAttributes == nil) {
        return;
    }
    
    NSDictionary<NSString *,id> *originTitleTextAttributes = self.titleTextAttributes;
    if (originTitleTextAttributes == nil) {
        [self wr_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    __block UIColor *titleColor;
    [originTitleTextAttributes enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqual:NSForegroundColorAttributeName]) {
            titleColor = (UIColor *)obj;
            *stop = YES;
        }
    }];
    
    if (titleColor == nil) {
        [self wr_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    if (newTitleTextAttributes[NSForegroundColorAttributeName] == nil) {
        newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    }
    [self wr_setTitleTextAttributes:newTitleTextAttributes];
}

@end

@implementation UINavigationController (WRAddition)

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.topViewController wr_statusBarStyle];
}

@end

@implementation UIViewController (WRAddition)

- (void)wr_setNavBarBackgroundImage:(UIImage *)image {
    if ([[self wr_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        UINavigationBar *navBar = (UINavigationBar *)[self wr_customNavBar];
        [navBar wr_setBackgroundImage:image];
    }
}

- (void)wr_setNavBarBarTintColor:(UIColor *)color {
    if ([[self wr_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        UINavigationBar *navBar = (UINavigationBar *)[self wr_customNavBar];
        [navBar wr_setBackgroundColor:color];
    }
}

- (void)wr_setNavBarBackgroundAlpha:(CGFloat)alpha {
    if ([[self wr_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        UINavigationBar *navBar = (UINavigationBar *)[self wr_customNavBar];
        [navBar wr_setBackgroundAlpha:alpha];
    }
}

- (void)wr_setNavBarTintColor:(UIColor *)color {
    if ([[self wr_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        UINavigationBar *navBar = (UINavigationBar *)[self wr_customNavBar];
        navBar.tintColor = color;
    }
}

- (void)wr_setNavBarTitleColor:(UIColor *)color {
    if ([[self wr_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        UINavigationBar *navBar = (UINavigationBar *)[self wr_customNavBar];
        navBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
    }
}

// statusBarStyle
- (UIStatusBarStyle)wr_statusBarStyle {
    id style = objc_getAssociatedObject(self, _cmd);
    return (style != nil) ? [style integerValue] : UIStatusBarStyleDefault;
}
- (void)wr_setStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, @selector(wr_statusBarStyle), @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}

// shadowImage
- (void)wr_setNavBarShadowImageHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, @selector(wr_navBarShadowImageHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self wr_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        UINavigationBar *navBar = (UINavigationBar *)[self wr_customNavBar];
        navBar.shadowImage = (hidden == YES) ? [UIImage new] : nil;
    }
}

- (BOOL)wr_navBarShadowImageHidden {
    id hidden = objc_getAssociatedObject(self, _cmd);
    return (hidden != nil) ? [hidden boolValue] : NO;
}

// custom navigationBar
- (UIView *)wr_customNavBar {
    UIView *navBar = objc_getAssociatedObject(self, _cmd);
    return (navBar != nil) ? navBar : [UIView new];
}
- (void)wr_setCustomNavBar:(UINavigationBar *)navBar {
    objc_setAssociatedObject(self, @selector(wr_customNavBar), navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
