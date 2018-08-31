//
//  NSString+ScCategory.h
//  SCWCommonCore
//
//  Created by YinZhongDong on 2018/8/30.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
@interface NSString (ScCategory)
// 1.上述方法能去除用户前后两端文字的空格
- (NSString*)trim;

// 2.MD5加密
- (NSString *)EX_MD5:(NSString *)string;

// 3.检测字符串是否为空
- (BOOL)isBlank;

// 4.检测字符串是否有效
- (BOOL)isValid;

// 5.字符串中单词的数量
- (NSUInteger)countNumberOfWords;

// 6.字符串是否包含子字符串
- (BOOL)containsString:(NSString *)subString;

// 7.字符串是否已给定的字符串为开头
- (BOOL)isBeginsWith:(NSString *)string;

// 8.字符串是否已给定的字符串为结尾
- (BOOL)isEndssWith:(NSString *)string;

// 9.用新字符替换字符串中的特定字符
- (NSString *)replaceCharacter:(NSString *)olderChar withCharcter:(NSString *)newerChar;

// 10.从特定的位置截取的子字符串
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end;

// 11.在字符串末添加新字符串
- (NSString *)addString:(NSString *)string;

// 12.从字符串中删除指定的字符串
- (NSString *)removeSubString:(NSString *)subString;

// 13.字符串只包含字母
- (BOOL)containsOnlyLetters;

// 14.字符串只包含数字
- (BOOL)containsOnlyNumbers;

// 15.字符串只包含字母和数字
- (BOOL)containsOnlyNumbersAndLetters;

// 16.当字符串在特定数组中可用
- (BOOL)isInThisarray:(NSArray*)array;

// 17.从数组中获取字符串
- (NSString *)getStringFromArray:(NSArray *)array;

// 18.字符串转换为数组
- (NSArray *)getArray;

// 19.字符串转换为二进制
- (NSData *)convertToData;

// 20.二进制转换为字符串
- (NSString *)convertToString:(NSData *)data;

// 21.是否为邮箱
- (BOOL)isValidEmail;

// 22.是否为美国手机号码
- (BOOL)isValidAmericanPhoneNumber;

// 24.是否为中国手机号码
- (BOOL)isValidChinesePhoneNumber;

// 23.是否为Url地址
- (BOOL)isValidUrl;

// 24.反转字符串
- (NSString *) reverseString;

// 25.判断密码是否符合规范
/*
 @param password 密码
 @return yes 为符合规范
 */
+ (BOOL)isStandardPassWord:(NSString *)password;

@end
