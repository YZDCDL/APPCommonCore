//
//  ScView.m
//  Songcw_Fr
//
//  Created by YinZhongDong on 2018/8/16.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#import "ScView.h"

@implementation ScView

- (instancetype)init{
    
    self = [super init];
    if (self) {
        [self setupViews];
        [self bindViewModel];
    }
    
    return self;
}

- (instancetype)initWithViewModel:(id<ScViewModelProtocol>)viewModel{
    
    self = [super init];
    if (self) {
        [self setupViews];
        [self bindViewModel];
    }
    
    return self;
}

//绑定数据
- (void)bindViewModel {
    
}

//初始化view
- (void)setupViews {
    
}

@end
