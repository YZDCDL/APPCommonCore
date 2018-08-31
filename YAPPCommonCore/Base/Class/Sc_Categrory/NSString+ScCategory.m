//
//  NSString+ScCategory.m
//  SCWCommonCore
//
//  Created by YinZhongDong on 2018/8/30.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#import "NSString+ScCategory.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (ScCategory)

// 1.上述方法能去除用户前后两端文字的空格
- (NSString*)trim{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

// 2.MD5加密
- (NSString *)EX_MD5:(NSString *)string{
    if (string == nil || [string length] == 0) {
        return nil;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

// 3.检测字符串是否为空
- (BOOL)isBlank{
    return ([[self trim] isEqualToString:@""]) ? YES : NO;
}

// 4.检测字符串是否有效
- (BOOL)isValid{
    return ([[self trim] isEqualToString:@""] || self == nil || [self isEqualToString:@"(null)"]) ? NO :YES;
}

// 5.字符串中单词的数量
- (NSUInteger)countNumberOfWords{
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSUInteger count = 0;
    while ([scanner scanUpToCharactersFromSet: whiteSpace  intoString: nil]) {
        count++;
    }
    
    return count;
}

// 6.字符串是否包含子字符串
- (BOOL)containsString:(NSString *)subString{
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}

// 7.字符串是否已给定的字符串为开头
- (BOOL)isBeginsWith:(NSString *)string{
    return ([self hasPrefix:string]) ? YES : NO;
}

// 8.字符串是否已给定的字符串为结尾
- (BOOL)isEndssWith:(NSString *)string{
    return ([self hasSuffix:string]) ? YES : NO;
}

// 9.用新字符替换字符串中的特定字符
- (NSString *)replaceCharacter:(NSString *)olderChar withCharcter:(NSString *)newerChar{
    return  [self stringByReplacingOccurrencesOfString:olderChar withString:newerChar];
}

// 10.从特定的位置截取的子字符串
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end{
    NSRange r;
    r.location = begin;
    r.length = end - begin;
    return [self substringWithRange:r];
}

// 11.在字符串末添加新字符串
- (NSString *)addString:(NSString *)string{
    if(!string || string.length == 0)
        return self;
    
    return [self stringByAppendingString:string];
}

// 12.从字符串中删除指定的字符串
- (NSString *)removeSubString:(NSString *)subString{
    if ([self containsString:subString])
    {
        NSRange range = [self rangeOfString:subString];
        return  [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}

// 13.字符串只包含字母
- (BOOL)containsOnlyLetters{
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

// 14.字符串只包含数字
- (BOOL)containsOnlyNumbers{
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

// 15.字符串只包含字母和数字
- (BOOL)containsOnlyNumbersAndLetters{
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

// 16.数组元素中是否包含该字符串
- (BOOL)isInThisarray:(NSArray*)array{
    for(NSString *string in array) {
        if([self isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

// 17.从数组中获取字符串
- (NSString *)getStringFromArray:(NSArray *)array{
    return [array componentsJoinedByString:@" "];
}

// 18.字符串转换为数组
- (NSArray *)getArray{
    return [self componentsSeparatedByString:@" "];
}

// 19.字符串转换为二进制
- (NSData *)convertToData{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

// 20.二进制转换为字符串
- (NSString *)convertToString:(NSData *)data{
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];
}

// 21.是否为邮箱
- (BOOL)isValidEmail{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}

// 22.是否为美国手机号码
- (BOOL)isValidAmericanPhoneNumber{
    NSString *regex = @"[235689][0-9]{6}([0-9]{3})?";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:self];
}

// 24.是否为中国手机号码
-(BOOL)isValidChinesePhoneNumber{
    NSString *regex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    if (!isMatch) {
        
        return NO;
    }
    
    return YES;
}

// 23.是否为Url地址
- (BOOL)isValidUrl{
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}

// 24.反转字符串
- (NSString *) reverseString{
    NSUInteger len = [self length];
    // self 表示字符串本身
    NSMutableString *retStr = [NSMutableString stringWithCapacity:len];
    while (len > 0) {
        unichar c = [self characterAtIndex:--len];
        // 从后取一个字符 unicode
        NSLog(@" c is %C", c);
        NSString *s = [NSString stringWithFormat:
                       @"%C", c];
        [retStr appendString:s];
    }
    
    if (retStr != nil && retStr.length > 0) {
        return [retStr copy];
    }else
    {
        return nil;
    }
}

// 25.判断密码是否符合规范
+ (BOOL)isStandardPassWord:(NSString *)password {
    if (!password) {
        return NO;
    }
    BOOL result;
    NSString * regex =  @"^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{6,16}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    result = [pred evaluateWithObject:password];
    
    return result;
}

@end
