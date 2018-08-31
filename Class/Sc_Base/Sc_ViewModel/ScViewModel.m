//
//  ScViewModel.m
//  Songcw_Fr
//
//  Created by YinZhongDong on 2018/8/16.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#import "ScViewModel.h"

@implementation ScViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    ScViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
    }
    return self;
}

//初始化
- (void)initialize{
    
}


#pragma 接收传过来的block
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock
{
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
    _failureBlock = failureBlock;
}

-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock{
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
}

@end
