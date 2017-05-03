//
//  TJProjectConfig.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/11.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJProjectConfig.h"
#import "IQKeyboardManager.h"
#import "Aspects.h"

@implementation TJProjectConfig

+(void)setSystemConfig{
    [[self class] setUIAppearance];
}

+ (void)setUIAppearance{
    //键盘管理
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [IQKeyboardManager sharedManager].enable = YES;
    
    [UIViewController aspect_hookSelector:@selector(viewDidLoad)
                    withOptions:AspectPositionAfter
                     usingBlock:^(id<AspectInfo> aspectInfo){
                         UIViewController *viewController = (UIViewController *)aspectInfo.instance;
                         NSString *className = NSStringFromClass([viewController class]);
                         if ([[className substringWithRange:NSMakeRange(0, 2)] isEqualToString:kClassPrefix
                              ]) {
                             //视图默认背景颜色
                             viewController.view.backgroundColor = [UIColor whiteColor];
                             [viewController setupForDismissKeyboard];
#if 1 //解决导航栏下压
                             //automaticallyAdjustsScrollViewInsets是一个bool类型，默认为YES，也就是会自动校准滚动视图的嵌入视图。不过这个只针对于UIScrollView及其子视图   automaticallyAdjustsScrollViewInsets改变的并不是UIScrollView的frame，而是它的内容区域contentView的可滚动区域，也就是scrollIndicatorInsets
                             if ([viewController respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
                                 [viewController setAutomaticallyAdjustsScrollViewInsets:NO];
                             }
                             //iOS 7中引入的新属性 默认值是UIRectEdgeAll 当容器是navigationController 时 ，默认布局将从navigationBar 顶部开始（所有UI元素都向上漂移了44pt）
                             if ([viewController respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
                                 [viewController setEdgesForExtendedLayout:UIRectEdgeNone];
                             }
#endif
                         }
                     }
                          error:nil];
    
    [[UIView appearance] setContentMode:UIViewContentModeScaleToFill];
    
    [[UIScrollView appearance] setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [[UITableView appearance] setSeparatorInset:UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 15.0f)];
    [[UITableView appearance] setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [[UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil] setTintColor:[UIColor blackColor]];
    //导航栏颜色
//    [[UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil] setBarTintColor:[UIColor redColor]];
    
    [[UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil] setBarStyle:UIBarStyleDefault];
    [[UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil] setTranslucent:YES];
    
    //导航栏字体
    NSDictionary *attributeDictionary = @{NSForegroundColorAttributeName:[UIColor blackColor],
                                                   NSShadowAttributeName:[NSShadow new],
                                          NSFontAttributeName:[UIFont defaultFontOfSize18]};
    [[UINavigationBar appearance] setTitleTextAttributes:attributeDictionary];
    //导航栏图片
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary *attributeDictionary1 = @{NSForegroundColorAttributeName:[UIColor blackColor],
                                          NSShadowAttributeName:[NSShadow new],
                                          NSFontAttributeName:[UIFont defaultFontOfSize15]};
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributeDictionary1 forState:UIControlStateNormal];
   //导航栏图片
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    //返回按钮图片
    UIImage *backImage = [UIImage imageNamed:@""];
    backImage = [backImage resizableImageWithCapInsets:UIEdgeInsetsMake(17, 9, 9, 9) resizingMode:UIImageResizingModeStretch];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationController class], nil] setBackButtonBackgroundImage:backImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationController class], nil] setBackButtonBackgroundImage:backImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}

/**
 遍历系统中所有字体
 */
+ (void)printFontNames{
    NSArray *familyNamesArray = [UIFont familyNames];
    NSString *familyName;
    NSMutableArray *fontNames = [NSMutableArray array];
    
    for (familyName in familyNamesArray) {
        NSArray *names = [UIFont fontNamesForFamilyName:familyName];
        [fontNames addObjectsFromArray:names];
    }
    TJLog(@"系统中所有字体:%@",fontNames);
}
@end
