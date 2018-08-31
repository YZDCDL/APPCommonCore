//
//  NSString+ScWebview.m
//  SCWCommonCore
//
//  Created by YinZhongDong on 2018/8/17.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#import "NSString+ScWebview.h"

@implementation NSString (ScWebview)
- (BOOL)ex_isMatch:(NSString *)pattern {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (error) {
        return NO;
    }
    NSTextCheckingResult *res = [regex firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    return res != nil;
}

- (BOOL)ex_isiTunesURL {
    return [self ex_isMatch:@"\\/\\/itunes\\.apple\\.com\\/"];
}

@end
