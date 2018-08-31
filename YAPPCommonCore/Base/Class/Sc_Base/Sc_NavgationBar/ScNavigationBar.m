//
//  ScNavigationBar.m
//  SCWCommonCore
//
//  Created by YinZhongDong on 2018/8/17.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#import "ScNavigationBar.h"
#import "Sc_SysMacro.h"
@implementation ScNavigationBar

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //    self.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    for (UIView *view in self.subviews) {
        if([NSStringFromClass([view class]) containsString:@"Background"]) {
            view.frame = self.bounds;
        }
        else if ([NSStringFromClass([view class]) containsString:@"ContentView"]) {
            CGRect frame = view.frame;
            frame.origin.y = iPhone_X ? 44 : 20;
            frame.size.height = self.bounds.size.height - frame.origin.y;
            view.frame = frame;
        }
    }
}

@end
