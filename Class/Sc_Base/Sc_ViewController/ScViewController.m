//
//  ScViewController.m
//  SCWCommonCore
//
//  Created by YinZhongDong on 2018/8/16.
//  Copyright © 2018年 YinZhongDong. All rights reserved.
//

#import "ScViewController.h"
#import "WRNavigationBar.h"
#import <Masonry/Masonry.h>

@interface ScViewController ()
@property (strong ,nonatomic) UIButton *ex_backButton;
@end

@implementation ScViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 默认view背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置Custom Bar
    [self _setupCustomNavigationBar];
    // 添加视图
    [self addSubViews];
    // 实时对 自定义的导航栏 进行布局
    [self.ex_navigationBar layoutIfNeeded];
    
    // 应用WR自定义Bar的设置
    [self wr_setCustomNavBar:self.ex_navigationBar];
    //****************** Pre Configer ******************************
    [self wr_setNavBarShadowImageHidden:YES];
    [self ex_setbackButtonColor:UIColorFromRGB(0x999999)];
    [self wr_setNavBarBarTintColor:UIColorFromRGB(0xf6f6f6)];
    [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
    
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = UIColorFromRGB(0x333333);
    textAttribute[NSFontAttributeName] = H18;
    [self.ex_navigationBar setTitleTextAttributes:textAttribute];
    
    //****************** Custom Method ******************************
    // 设置Nagigation
    [self layoutNavigation];
    // 绑定ViewModel
    [self bindViewModel];
    
    // 调整布局约束
    [self updateViewConstraints];
}


#pragma mark - ================ system method ===============
- (void)dealloc {
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}


#pragma mark - Base Implementation
- (void)layoutNavigation{}
- (void)addSubViews{}
- (void)bindViewModel{}

#pragma mark - View Appear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view bringSubviewToFront:self.ex_navigationBar];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIViewController *topVC = self.navigationController.topViewController;
    if (![topVC isKindOfClass:NSClassFromString(@"ScViewController")]) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}


#pragma mark - Modify System
- (NSString *)title{
    return [super title];
}

- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    self.ex_navigationItem.title = title;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return [self wr_statusBarStyle];
}

#pragma mark - Private Method
- (void)_setupCustomNavigationBar{
    //    CGFloat statusBar = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat _barHeight = iCCNavigationHeight;
    
    [self.view addSubview:self.ex_navigationBar];
    [self.ex_navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(_barHeight);
    }];
    
    self.ex_navigationBar.items = @[self.ex_navigationItem];

    [self _setupBackBtn];
}

- (void)_setupBackBtn{
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[ScIMAGE(@"navigationButtonReturn") imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        backButton.frame = CGRectMake(0, 0, backButton.currentImage.size.width + 5, 44);
        [backButton addTarget:self action:@selector(_popView) forControlEvents:UIControlEventTouchUpInside];
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0); // 这里微调返回键的位置
        
        self.ex_navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        // 持有他
        self.ex_backButton = backButton;
    }
}

- (void)_popView{
    self.ex_popBlock?self.ex_popBlock():[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Public Method
- (void)ex_setbackButtonColor:(UIColor *)color{
    self.ex_backButton.tintColor = color;
}

#pragma mark - Lazy Load
- (ScNavigationBar *)ex_navigationBar{
    if (!_ex_navigationBar) {
        _ex_navigationBar = [ScNavigationBar new];
    }
    return _ex_navigationBar;
}

- (UINavigationItem *)ex_navigationItem{
    if (!_ex_navigationItem) {
        _ex_navigationItem = [UINavigationItem new];
    }
    return _ex_navigationItem;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (CGFloat)navigationHeight{
    if (iPhone_X) {
        return 64 + 24;
    } else {
        return 64;
    }
}


@end
