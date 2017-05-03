//
//  TJOrientationViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/5/3.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJOrientationViewController.h"

@interface TJOrientationViewController ()

@end

@implementation TJOrientationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(60, 100, 200, 60)];
    textField.placeholder = @"test";
    //1.kvc
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont systemFontOfSize:16.0f] forKeyPath:@"_placeholderLabel.font"];
    //2.富文本
    NSAttributedString *textFIeldPlaceholder = [[NSAttributedString alloc]initWithString:@"test" attributes:@{NSForegroundColorAttributeName:[UIColor greenColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0f]}];
    textField.attributedPlaceholder = textFIeldPlaceholder;
    //光标颜色
    textField.tintColor = [UIColor redColor];
    //光标位置
    textField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textField];
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(60);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(60);
    }];
    
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"button" forState:UIControlStateNormal];
    
    self.navigationItem.title = @"Orientation";
    //获取设备方向发生的变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:)name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)orientChange:(NSNotification *)notification
{
    
    //NSDictionary* ntfDict = [notification userInfo];
    //宣告一個UIDevice指標，並取得目前Device的方向
    UIDeviceOrientation  orient = [UIDevice currentDevice].orientation;
    /*
     UIDeviceOrientationUnknown,
     UIDeviceOrientationPortrait,            // Device oriented vertically, home button on the bottom
     UIDeviceOrientationPortraitUpsideDown,  // Device oriented vertically, home button on the top
     UIDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
     UIDeviceOrientationLandscapeRight,      // Device oriented horizontally, home button on the left
     UIDeviceOrientationFaceUp,              // Device oriented flat, face up
     UIDeviceOrientationFaceDown             // Device oriented flat, face down   */
    
    //取得當前Device的方向，來當作判斷敘述。（Device的方向型態為Integer）
    switch (orient) {
        case UIDeviceOrientationFaceUp:
            NSLog(@"螢幕朝上平躺");
            break;
            
        case UIDeviceOrientationFaceDown:
            NSLog(@"螢幕朝下平躺");
            break;
            
            //系統無法判斷目前Device的方向，有可能是斜置
        case UIDeviceOrientationUnknown:
            NSLog(@"未知方向");
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"螢幕向左橫置");
            break;
            
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"螢幕向右橫置");
            break;
            
        case UIDeviceOrientationPortrait:
            NSLog(@"螢幕直立");
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"螢幕直立，上下顛倒");
            break;
            
        default:
            NSLog(@"無法辨識");
            break;
    }
}
/*
 Device Orientation 设备的物理方向
 
 Interface Orientation 界面的显示方向
 **/

#pragma mark -
//是否支持旋转
- (BOOL)shouldAutorotate{
    return YES;
}

//支持哪些方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}
//默认初始显示方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //1.私有方法 不推荐但是很有效 上传appstore有被拒的风险
    //[[UIDevice currentDevice] setValue:@(UIDeviceOrientationLandscapeLeft) forKey:@"orientation"];
    
    //2.假旋转 并未改变UIDevice的orientation而是改变某个view的transform 利用CGAffineTransformMakeRotation达到目的（思路是先设置statusBarOrientation，然后再改变某个view的方向跟statusBarOrinetation 一致）注意：先关闭自动选转，否则setStatusBarOrientation无效
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
    self.view.transform = CGAffineTransformMakeRotation(M_PI/2);
    self.view.bounds = CGRectMake(0, 0, kMainScreenHeight, kMainScreenWidth);
    
}
//
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
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
