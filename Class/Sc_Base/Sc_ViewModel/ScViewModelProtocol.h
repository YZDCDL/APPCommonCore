//
//  ScViewModelProtocol.h
//  Songcw_Fr
//
//  Created by YinZhongDong on 2018/8/16.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScViewModelProtocol <NSObject>

@optional
// 1.初始化
- (void)initialize;

// 2.初始化Model
- (instancetype)initWithModel:(id)model;

// 3.获取数据
- (void) fetchData;

@end
