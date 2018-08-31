//
//  Sc_AppMacro.h
//  SCWCommonCore
//
//  Created by YinZhongDong on 2018/8/16.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#ifndef Sc_AppMacro_h
#define Sc_AppMacro_h

/* Bundle Info.plist */
#define Sc_BundleInfoPlist                  [[NSBundle mainBundle] infoDictionary]
/* Bundle ID */
#define Sc_Bundle_ID                        [[NSBundle mainBundle] bundleIdentifier]
/* Bundle Version */
#define Sc_Bundle_Version                   [Sc_BundleInfoPlist objectForKey:@"CFBundleVersion"]
/* Bundle ShortVersion */
#define Sc_Bundle_ShortVersion              [Sc_BundleInfoPlist objectForKey:@"CFBundleShortVersionString"]


//** DEBUG LOG **************************************************
#ifdef DEBUG1

#define DLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#else

//#define DLog( s, ... )
#define DLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#endif





//** Screen Frame **************************************************
//获取APP Frame
#define Application_Frame       [[UIScreen mainScreen] applicationFrame]

//获取APP Height&Width
#define App_Frame_Height        [[UIScreen mainScreen] applicationFrame].size.height
#define App_Frame_Width         [[UIScreen mainScreen] applicationFrame].size.width

//获取屏幕 宽度、高度 bounds就是屏幕的全部区域
#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height




//View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height
#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)
#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)
#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

//改变View设置
#define RECT_CHANGE_x(v,x)          CGRectMake(x, Y(v), WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_y(v,y)          CGRectMake(X(v), y, WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_point(v,x,y)    CGRectMake(x, y, WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_width(v,w)      CGRectMake(X(v), Y(v), w, HEIGHT(v))
#define RECT_CHANGE_height(v,h)     CGRectMake(X(v), Y(v), WIDTH(v), h)
#define RECT_CHANGE_size(v,w,h)     CGRectMake(X(v), Y(v), w, h)

//系统控件默认高度
#define ScStatusBarHeight        (20.f)             //状态栏默认高度
#define ScTopBarHeight           (44.f)             //TopBar默认高度
#define ScNavigateBarHeight      (64.f)             //状态栏默认高度
#define ScBottomBarHeight        (49.f)             //BottomBar默认高度
#define ScCellDefaultHeight      (44.f)             //Cell默认高度
#define ScEnglishKeyboardHeight  (216.f)            //英文键盘高度
#define ScChineseKeyboardHeight  (252.f)            //中文键盘高度
#define ScAlertButtonHeight      (45.f)             //alert按钮高度


//PNG&&JPG 图片路径
#define PNGPATH(NAME)          [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)          [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME, EXT)        [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

//加载图片
#define ScIMAGE(imgName)       [UIImage imageNamed:imgName]
#define PNGkImg(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGkImg(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMG_TYPE(NAME, EXT)       [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]


//** 常用操作 ***********************************************
#define URL(url) [NSURL URLWithString:url]                                          //字符串转URL
#define STRINGAPPLEND(str1,str2) [NSString stringWithFormat:@"%@%@",str1,str2]      //字符串拼接
#define Sc_STR(str) [NSString stringWithFormat:@"%@",str]                           //格式化为string类型
#define Sc_NUM(num) [NSString stringWithFormat:@"%d",num]                           //格式化为int类型
#define Sc_LONG(num) [NSString stringWithFormat:@"%ld",num]                         //格式化为long int类型
#define ScSTR_INT(int_str) [NSString stringWithFormat:@"%ld",int_str];              //int转字符串类型
#define ScSTR_FLOAT(float_str) [NSString stringWithFormat:@"%.2f",float_str];       //float转字符串类型，保留两位小数

//** 随机数据 ***********************************************************************************
#define RandomTitle [NSString stringWithFormat:@"随机标题---%d", arc4random_uniform(1000000)]
#define RandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

//** 字体颜色设置 ***********************************************
//默认字体
#define Sc_CHINESE_FONT(FONTSIZE) [UIFont fontWithName:@"MicrosoftYaHei" size:(FONTSIZE)]           //微软雅黑
#define Sc_ENGLISH_FONT(FONTSIZE) [UIFont fontWithName:@"Helvetica Light" size:(FONTSIZE)]          //英文和数字


//系统字体
#define H30 [UIFont systemFontOfSize:30]
#define H29 [UIFont systemFontOfSize:29]
#define H28 [UIFont systemFontOfSize:28]
#define H27 [UIFont systemFontOfSize:27]
#define H26 [UIFont systemFontOfSize:26]
#define H25 [UIFont systemFontOfSize:25]
#define H24 [UIFont systemFontOfSize:24]
#define H23 [UIFont systemFontOfSize:23]
#define H22 [UIFont systemFontOfSize:22]
#define H20 [UIFont systemFontOfSize:20]
#define H19 [UIFont systemFontOfSize:19]
#define H18 [UIFont systemFontOfSize:18]
#define H17 [UIFont systemFontOfSize:17]
#define H16 [UIFont systemFontOfSize:16]
#define H15 [UIFont systemFontOfSize:15]
#define H14 [UIFont systemFontOfSize:14]
#define H13 [UIFont systemFontOfSize:13]
#define H12 [UIFont systemFontOfSize:12]
#define H11 [UIFont systemFontOfSize:11]
#define H10 [UIFont systemFontOfSize:10]
#define H8 [UIFont systemFontOfSize:8]

///粗体
#define HB20 [UIFont boldSystemFontOfSize:20]
#define HB18 [UIFont boldSystemFontOfSize:18]
#define HB17 [UIFont boldSystemFontOfSize:17]
#define HB16 [UIFont boldSystemFontOfSize:16]
#define HB15 [UIFont boldSystemFontOfSize:15]
#define HB14 [UIFont boldSystemFontOfSize:14]
#define HB13 [UIFont boldSystemFontOfSize:13]
#define HB12 [UIFont boldSystemFontOfSize:12]
#define HB11 [UIFont boldSystemFontOfSize:11]
#define HB10 [UIFont boldSystemFontOfSize:10]
#define HB8 [UIFont boldSystemFontOfSize:8]



///常用颜色
#define black_color     [UIColor blackColor]
#define blue_color      [UIColor blueColor]
#define brown_color     [UIColor brownColor]
#define clear_color     [UIColor clearColor]
#define darkGray_color  [UIColor darkGrayColor]
#define darkText_color  [UIColor darkTextColor]
#define white_color     [UIColor whiteColor]
#define yellow_color    [UIColor yellowColor]
#define red_color       [UIColor redColor]
#define orange_color    [UIColor orangeColor]
#define purple_color    [UIColor purpleColor]
#define lightText_color [UIColor lightTextColor]
#define lightGray_color [UIColor lightGrayColor]
#define green_color     [UIColor greenColor]
#define gray_color      [UIColor grayColor]
#define magenta_color   [UIColor magentaColor]
#define random_color    [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

//自定义颜色(RGB)
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//角度
#define ScDTOR(x) (M_PI*(x)/ 180.0)                           //由角度转换弧度
#define ScRToD(x) (x * 180.0)/(M_PI)                          //由弧度转换角度


//** View常用操作 *******************************************

//View加圆角和边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//View加圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]



//** 单例 ***************************************
#undef    AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__                  = [[__class alloc] init]; } ); \
return __singleton__; \
}

#undef  RE_SINGLETON
#define RE_SINGLETON(__class) [__class sharedInstance]



//** strong self & weak self *******************
#define WEAKSELF typeof(self) __weak weakSelf           = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

/**
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


#endif /* Sc_AppMacro_h */
