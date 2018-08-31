//
//  NSString+ScWebview.h
//  SCWCommonCore
//
//  Created by YinZhongDong on 2018/8/17.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ScWebview)

- (BOOL)ex_isMatch:(NSString *)pattern;
- (BOOL)ex_isiTunesURL;

@end
