//
//  ScViewProtocol.h
//  Songcw_Fr
//
//  Created by YinZhongDong on 2018/8/13.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScViewModelProtocol;

@protocol ScViewProtocol <NSObject>

@optional

#pragma mark - ScView Init

// 1.初始化ViewModel
- (instancetype)initWithViewModel:(id <ScViewModelProtocol>)viewModel;
// 2.绑定数据源
- (void)bindViewModel;
// 3.设置子视图
- (void)setupViews;

@end
