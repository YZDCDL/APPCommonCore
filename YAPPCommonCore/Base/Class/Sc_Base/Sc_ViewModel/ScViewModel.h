//
//  ScViewModel.h
//  Songcw_Fr
//
//  Created by YinZhongDong on 2018/8/16.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScViewModelProtocol.h"

//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (NSDictionary *errorInfo);
typedef void (^FailureBlock)(void);

@interface ScViewModel : NSObject <ScViewModelProtocol>

@property (strong, nonatomic) ReturnValueBlock returnBlock;
@property (strong, nonatomic) ErrorCodeBlock errorBlock;
@property (strong, nonatomic) FailureBlock failureBlock;

/**
 传入交互的Block块
 @param returnBlock 数据成功返回Blcok
 @param errorBlock 错误返回Block
 @param failureBlock 失败返回Block
 */
- (void)setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock;

/**
 传入交互的Block块（不包含失败返回Block）
 @param returnBlock 数据成功返回Blcok
 @param errorBlock 错误返回Block
 */
- (void)setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock;

@end
