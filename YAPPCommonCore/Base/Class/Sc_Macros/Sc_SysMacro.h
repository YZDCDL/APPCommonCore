//
//  Sc_SysMacro.h
//  SCWCommonCore
//
//  Created by YinZhongDong on 2018/8/16.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#ifndef Sc_SysMacro_h
#define Sc_SysMacro_h

//** 系统版本 **************************************************
#define IOS_VERSION          ([[[UIDevice currentDevice] systemVersion] floatValue])   //IOS版本
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])                //当前系统版本
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])              //当前系统语言
#define VersionLargerThan7   [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define VersionLargerThan8   [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define VersionLargerThan9   [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0
#define VersionLargerThan10  [[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0
#define VersionLargerThan11  [[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0
#define Version7  ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0)
#define Version8  ([[[UIDevice currentDevice] systemVersion] floatValue] == 8.0)

//判断系统版本高于或者低于某一个版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//** 判断手机型号 **************************************************
//1.iPhone4分辨率320x480，像素640x960，@2x
//2.iPhone5分辨率320x568，像素640x1136，@2x
//3.iPhone67分辨率375x667，像素750x1334，@2x
//4.iPhone Plus分辨率414x736，像素1242x2208，@3x

// 判断是否为 iPhone 4
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否为 iPhone 5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f
// 判断是否为iPhone 6/6s
#define iPhone_67 [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// 判断是否为iPhone 6Plus/6sPlus
#define iPhone_Plus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f
#define iPhone_X [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 812.0f
// 判断是否为Retina屏
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否为iPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)



#endif /* Sc_SysMacro_h */
