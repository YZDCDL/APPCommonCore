//
//  ScViewController.h
//  SCWCommonCore
//
//  Created by YinZhongDong on 2018/8/16.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScViewcontrollerProtocol.h"
#import "ScNavigationBar.h"
#import "Sc_SysMacro.h"
// 导航栏所占高度
#define iCCNavigationHeight [ScViewController navigationHeight]

typedef void(^ScNavigationPopBlock)(void);


@interface ScViewController : UIViewController <ScViewcontrollerProtocol>


/**
 对 这就是咱们VC控制的那个导航栏
 @important 系统的UINavigationController上的导航栏已经隐藏掉了，不要试图去使用，没有用的
 */
@property (strong ,nonatomic) ScNavigationBar * ex_navigationBar;

/**
 用于替换系统的 self.navigationItem.rightBarButtonItem
 @important 现在这样用: self.ex_navigationItem.rightBarButtonItem = XXX
 */
@property (strong ,nonatomic) UINavigationItem *ex_navigationItem;

/**
 用于拦截返回按钮的点击事件
 @important 有了这个不要再改写返回按钮
 */
@property (copy ,nonatomic) ScNavigationPopBlock ex_popBlock;

/**
 修改返回按钮的颜色
 
 如果要修改 导航栏上所有元素的颜色 必须设置 [self ex_setbackButtonColor:nil];
 然后 使用 [self wr_setNavBarTintColor:xxx_color]; 来统一管理
 
 @param color 对，你想要的颜色 Eng: Set the color ,that you wanna the back button to be.
 */
- (void)ex_setbackButtonColor:(UIColor *)color;

+ (CGFloat)navigationHeight;
@end
