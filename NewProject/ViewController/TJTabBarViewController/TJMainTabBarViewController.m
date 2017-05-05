//
//  TJMainTabBarViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/16.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJMainTabBarViewController.h"

#import "TJFirstViewController.h"
#import "TJSecondViewController.h"
#import "TJThirdViewController.h"
#import "TJFourViewController.h"

#import "UIStoryboard+NewProject.h"
#import "UITabBar+TJBadge.h"

@interface TJMainTabBarViewController ()

@property (nonatomic, strong, nullable)UIWindow *window;
/**
 之前被选中的UITabBarItem
 */
@property (nonatomic, strong, nullable)UITabBarItem *lastTabBarItem;

@end

@implementation TJMainTabBarViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //将默认被选中的tabBarItem保存为属性
    self.lastTabBarItem = self.tabBar.selectedItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTabBarItem];
}

- (void)setupTabBarItem{
    NSArray *titleArray = @[@"首页",
                            @"咨询",
                            @"UIKit",
                            @"我的"];
    
    NSArray *iconArray  = @[@"MainTabItemIcon_0",
                            @"MainTabItemIcon_1",
                            @"MainTabItemIcon_2",
                            @"MainTabItemIcon_4"];
    
    NSArray *iconSelectArray = @[@"MainTabItemIcon_Select_0",
                                 @"MainTabItemIcon_Select_1",
                                 @"MainTabItemIcon_Select_2",
                                 @"MainTabItemIcon_Select_4"];
    
    TJFirstViewController *firstController = [[UIStoryboard FirstTabStoryboard] instantiateViewControllerWithIdentifier:TJFirstViewController_Storyboard];
    UINavigationController *v1 = [[UINavigationController alloc]initWithRootViewController:firstController];
    
    TJSecondViewController *secondController = [[UIStoryboard SecondTabStoryboard] instantiateViewControllerWithIdentifier:TJSecondViewController_Storyboard];
    UINavigationController *v2 = [[UINavigationController alloc]initWithRootViewController:secondController];
    
    TJThirdViewController *thirdController = [[UIStoryboard ThirdTabStoryboard] instantiateViewControllerWithIdentifier:TJThirdViewController_Storyboard];
    UINavigationController *v3 = [[UINavigationController alloc]initWithRootViewController:thirdController];
    
    TJFourViewController *fourController = [[UIStoryboard FourTabStoryboard] instantiateViewControllerWithIdentifier:TJFourViewController_Storyboard];
    UINavigationController *v4 = [[UINavigationController alloc]initWithRootViewController:fourController];
    self.viewControllers = @[v1,v2,v3,v4];
    
    NSDictionary *tabBarNormalColor = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
    NSDictionary *tabBarSelectedColor = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"96cc29"], NSForegroundColorAttributeName, nil];
    
    for (NSUInteger i = 0; i < self.viewControllers.count; i++) {
        UITabBarItem *item = self.tabBar.items[i];
        //文字位置
        item.titlePositionAdjustment = UIOffsetMake(0, -3);
        //图片位置
        //item.imageInsets = UIEdgeInsetsMake(-1, -2, 0, 0);
        [item setTitle:titleArray[i]];
        [item setImage:[[UIImage imageNamed:iconArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item setSelectedImage:[[UIImage imageNamed:iconSelectArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [item setTitleTextAttributes:tabBarNormalColor forState:UIControlStateNormal];
        [item setTitleTextAttributes:tabBarSelectedColor forState:UIControlStateSelected];
    }
    //默认选中首页
    self.selectedIndex = 0;
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    //本次点击的UITabBarItem是否和上次的一样
    if (item == self.lastTabBarItem) {//一样则抛出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:TJTabBarDidClickNotification object:nil userInfo:nil];
    }
    self.lastTabBarItem = item;
}
#pragma mark -  
//禁止屏幕旋转，在需要旋转的页面再打开
//- (BOOL)shouldAutorotate{
//    return NO;
//}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark - TJRoutesDelegate
- (void)shouldPushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *visibleViewController = [UIApplication sharedApplication].keyWindow.currentVisibleViewController;
    if (visibleViewController.navigationController.viewControllers.count > 0) {
        //隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if (visibleViewController.navigationController) {
        [visibleViewController.navigationController pushViewController:viewController animated:YES];
    } else{
        [((UINavigationController *)self.selectedViewController) pushViewController:viewController animated:YES];
    }
}

- (void)shouldPresentViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *visibleViewController = [UIApplication sharedApplication].keyWindow.currentVisibleViewController;
    [visibleViewController presentViewController:viewController animated:animated completion:^{
        
    }];
}
//向视图控制器容器中添加子视图控制器
//- (void)addChildViewController:(UIViewController *)childController{
//    
//}

 //从父视图控制器中删除
//- (void)removeFromParentViewController{
//    
//}
 /*交换两个子视图控制器的位置（由于添加的顺序不同，所以子试图控制器在父视图控制器中存在层次关系）
  romViewController：当前显示的子试图控制器，将被替换为非显示状态
  
  toViewController：将要显示的子视图控制器
  
  duration：交换动画持续的时间，单位秒
  
  options：动画的方式
  
  animations：动画Block
  
  completion：完成后执行的Block
  */
//- (void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion{
//    
//}
/*当一个视图控制器从视图控制器容器中被添加或者被删除之前，该方法被调用
 parent：父视图控制器，如果没有父视图控制器，将为nil
 
 注意点：
 1.当我们向我们的视图控制器容器中调用removeFromParentViewController方法时，必须要先调用该方法，且parent参数为nil：
 
 [将要删除的视图控制器 willMoveToParentViewController:nil];
 
 2.当我们调用addChildViewController方法时，在添加子视图控制器之前将自动调用该方法。所以，就不需要我们显示调用了。
 */
//- (void)willMoveToParentViewController:(UIViewController *)parent{
//    
//}

#pragma mark - 向视图控制器容器中添加子视图控制器
- (void)shouldAddChildViewController:(UIViewController *)childViewController{
    if (self.window) {
        if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
            UIViewController *topViewController = navigationController.topViewController;
            [childViewController willMoveToParentViewController:topViewController];
            [navigationController.view setFrame:navigationController.view.frame];
            [self.window addSubview:childViewController.view];
            [topViewController addChildViewController:childViewController];
            [childViewController didMoveToParentViewController:topViewController];
        }
    }
}

- (void)shouldKeyWindowViewController:(UIViewController *)viewController{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.opaque = YES;
    self.window.windowLevel = UIWindowLevelStatusBar;
    self.window.rootViewController = viewController;
    [self.window makeKeyWindow];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    viewController.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, CGRectGetHeight([UIScreen mainScreen].bounds));
    [UIView animateWithDuration:0.25 animations:^{
        viewController.view.transform = CGAffineTransformIdentity;
    }];
}

- (void)dismissKeyWindowViewController:(UIViewController *)viewController{
    [viewController viewWillDisappear:YES];
    [viewController viewDidDisappear:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [UIView animateWithDuration:0.25 animations:^{
        if (viewController.navigationController) {
            viewController.navigationController.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, CGRectGetHeight([UIScreen mainScreen].bounds));
        }else{
            viewController.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, CGRectGetHeight([UIScreen mainScreen].bounds));
            
        }
    } completion:^(BOOL finished) {
        [viewController.view removeFromSuperview];
        [self.window removeFromSuperview];
        [self.window resignKeyWindow];
        self.window = nil;
        UIWindow *window = [UIApplication sharedApplication].windows[0];
        [window makeKeyWindow];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
