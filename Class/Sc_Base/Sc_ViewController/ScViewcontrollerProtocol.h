//
//  ScViewcontrollerProtocol.h
//  SCWCommonCore
//
//  Created by YinZhongDong on 2018/8/16.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ScViewModelProtocol;

@protocol ScViewcontrollerProtocol <NSObject>
#pragma mark ================ public method ===============
// 1.加载viewModel
- (instancetype)initWithViewModel:(id <ScViewModelProtocol>) viewModel;

// 2.绑定视图和数据
- (void)bindViewModel;

// 3.添加子视图
- (void)addSubViews;

// 4.设置导航条
- (void)layoutNavigation;

// 5.加载数据（未完成）
//- (void)loadData;

// 6.键盘回收（未完成）
//- (void)recoverKeyboard;


#pragma mark ================ private method ===============
// 7.重新载入VC（未完成）
//- (void)reloadViewController;

// 8.返回上一层
- (void)backToPreviousView;

// 9.加载空视图（未完成）
//- (void)addReloadView:(void (^)())eventBlock;

// 10.移除空视图
- (void)removeReloadView;


@end
