//
//  UINavigationBar+DBExtension.h
//  EXCommonCore
//
//  Created by Xu Mengtong on 22/9/17.
//  Copyright © 2017年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (DBExtension)

- (void)db_setBackgroundImage:(UIImage *)image;
- (void)db_setBackgroundColor:(UIColor *)color;
- (void)db_setBackgroundAlpha:(CGFloat)alpha;
- (void)db_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;
- (void)db_setTranslationY:(CGFloat)translationY;
- (CGFloat)db_getTranslationY;

@end

@interface UIImage (DBNavigationBarExtension)

+ (UIImage *)_db_imageWithColor:(UIColor *)color alpha:(CGFloat)alpha;

@end

