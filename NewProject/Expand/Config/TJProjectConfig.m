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
    [[self class] keyboardManager];
    [[self class] setUIAppearance];
}

/**键盘管理*/
+ (void)keyboardManager {

    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义

    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框

    keyboardManager.enableAutoToolbar = NO; // 控制是否显示键盘上的工具条

    keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字

    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体

    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离

}
+ (void)setUIAppearance{
//    //键盘管理
//    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
//    [IQKeyboardManager sharedManager].enable = YES;

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
    //    [[UIView appearance] setContentMode:UIViewContentModeScaleToFill];//慎用 会影响storyboard UIview相关控件的显示

//    [[UIView appearance] setContentMode:UIViewContentModeScaleToFill];
    /*
     参考：https://blog.csdn.net/u011363981/article/details/73294499
     setExclusiveTouch  是UIView的一个属性，默认为NO（不互斥），设置UIView 接收手势的互斥性为YES，防止多个响应区域被“同时”点击，“同时”响应的问题。
     1.可以通过  [[UIView appearance] setExclusiveTouch:YES]; UIImageView ，UILabel等，都可以添加手势，响应方式和UIButton 相同。全局设置响应区域的点击手势的互斥，是有效的
     */
    [[UIView appearance] setExclusiveTouch:YES];

    [[UIScrollView appearance] setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    [[UITableView appearance] setSeparatorInset:UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 15.0f)];
    [[UITableView appearance] setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [[UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil] setTintColor:[UIColor blackColor]];
    //导航栏颜色
    [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[UINavigationController class]]] setBarTintColor:[UIColor redColor]];
    //半透明模糊
    [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[UINavigationController class]]]setTranslucent:YES];

    [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[UINavigationController class]]]setBarStyle:UIBarStyleDefault];

    //导航栏字体
    NSDictionary *attributeDictionary = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                   NSShadowAttributeName:[NSShadow new],
                                          NSFontAttributeName:[UIFont defaultFontOfSize20]};
    [[UINavigationBar appearance] setTitleTextAttributes:attributeDictionary];
    //导航栏图片
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    //在tabBarViewController中设置
//    NSDictionary *attributeDictionary1 = @{NSForegroundColorAttributeName:[UIColor blackColor],
//                                          NSShadowAttributeName:[NSShadow new],
//                                          NSFontAttributeName:[UIFont defaultFontOfSize15]};
//    [[UIBarButtonItem appearance] setTitleTextAttributes:attributeDictionary1 forState:UIControlStateNormal];
   //导航栏图片
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    //返回按钮图片
    UIImage *backImage = [UIImage imageNamed:@""];
    backImage = [backImage resizableImageWithCapInsets:UIEdgeInsetsMake(17, 9, 9, 9) resizingMode:UIImageResizingModeStretch];

    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UINavigationController class]]] setBackgroundImage:backImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UINavigationController class]]] setBackgroundImage:backImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
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
