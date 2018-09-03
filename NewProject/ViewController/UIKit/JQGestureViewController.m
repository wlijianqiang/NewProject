//
//  JQGestureViewController.m
//  NewProject
//
//  Created by lijianqiang on 2018/8/28.
//  Copyright © 2018年 STV. All rights reserved.
//

#import "JQGestureViewController.h"


@interface JQGestureViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic ,strong)UIImageView *imageView;
@property (nonatomic ,strong)UIView      *gestureView;

@end

@implementation JQGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor defaultColor];
    [self createImageView];
//    [self tapGestureMethod];
    [self pinchGestureMethod];
}

- (void)createImageView {
    // 初始化一个UIimageView
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 100, kMainScreenWidth - 100, 300)];
    self.imageView.image = [UIImage imageNamed:@"1.jpg"];

    // UIImageView的用户交互是默认关闭的，要想使他可以处理触摸事件，我们得手动打开它
    [self.imageView setUserInteractionEnabled:YES];
    [self.view addSubview:self.imageView];


    //初始化一个视图（响应者）来承载手势
    self.gestureView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
     //当前视图放置到屏幕中央
     self.gestureView.center = self.view.center;
     self.gestureView.backgroundColor = [UIColor yellowColor];
     [self.view addSubview:self.gestureView];
}

/**
 点击手势(单击、双击、N击)
 */
- (void)tapGestureMethod {
    //创建轻拍手势
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    //设置触控对象的个数（几个手指）
    [tapGR setNumberOfTouchesRequired:1];
    //设置轻拍次数
    [tapGR setNumberOfTapsRequired:2];
    //给图片添加手势  一个视图可以添加多种手势，但是一个手势，只能添加到一个视图上

    [self.gestureView addGestureRecognizer:tapGR];
}

//轻拍手势的回调方法
- (void)tapAction:(UITapGestureRecognizer*)sender{
    //可以根据手势得到它当前所作用的视图
//    UIImageView *imageView = (UIImageView*)sender.view;
    TJLog(@"我轻拍了gestureView");
}

/**
 捏合手势
 */
- (void)pinchGestureMethod {
    //创建捏合手势
    UIPinchGestureRecognizer* pinchGR = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    pinchGR.delegate = self; // 可以在同一个视图上实现多个手势
    [self.gestureView addGestureRecognizer:pinchGR];

}

//捏合手势的回调方法
- (void)pinchAction:(UIPinchGestureRecognizer*)sender {

    //通过捏合手势的到缩放比率
//    float scale = sender.scale;
    //得到该手势所作用的视图
    UIView *view = sender.view;
    //2D仿射变换函数中的缩放函数来实现视图的放大缩小

    //是在原有基础上来改变当前的视图
    //函数的第一个参数：现有的视图的transform值
    //第二个参数：x轴上的缩放比率
    //第三个参数:y轴上的缩放比率

    //是在视图最初的transform状态上改变，不管执行多少次，都是以该视图最初的transform状态为基础来改变
    view.transform = CGAffineTransformMakeScale(2, 2);
    //    view.transform = CGAffineTransformScale(view.transform, scale, scale);
    //每次捏合动作完毕之后，让此捏合值复原，使得它每次都是从100%开始缩放
    sender.scale = 1;
}

/**
 旋转手势
 */
- (void)rotatGestureMethod {
    UIRotationGestureRecognizer* rotaGR = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotaAction:)];
    rotaGR.delegate = self;
    [self.gestureView addGestureRecognizer:rotaGR];

}

//旋转手势回调方法
- (void)rotaAction:(UIRotationGestureRecognizer*)sender{
    //通过手势的到旋转角度
    float rota = sender.rotation;
    //得到该手势作用的视图
    UIView *view = sender.view;
    //通过2D仿射变换函数中的旋转函数来使得当前视图旋转。
    view.transform = CGAffineTransformRotate(view.transform, rota);
    //复原
    //    sender.rotation = 0;
    sender.rotation = 0;
}

/**
 平移手势
 */
- (void)panGestureMethod {
    //平移手势
    UIPanGestureRecognizer *panGP = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.gestureView addGestureRecognizer:panGP];
}

//平移手势的回调方法
- (void)panAction:(UIPanGestureRecognizer*)sender{
    //得到当前手势所在视图
    UIView *view = sender.view;
    //得到我们在视图上移动的偏移量
    CGPoint currentPoint = [sender translationInView:view.superview];
    //通过2D仿射变换函数中与位移有关的函数实现视图位置变化
    view.transform = CGAffineTransformTranslate(view.transform, currentPoint.x, currentPoint.y);
    //复原 // 每次都是从00点开始
    [sender setTranslation:CGPointZero inView:view.superview];
}

/**
 边缘清扫手势
 */
- (void)edgePanGestureMethod {
    //边缘轻扫手势
    UIScreenEdgePanGestureRecognizer *edgePanGR = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanAction:)];
    edgePanGR.edges = UIRectEdgeAll;
    [self.gestureView addGestureRecognizer:edgePanGR];
}

//边缘轻扫手势回调方法
- (void)edgePanAction:(UIScreenEdgePanGestureRecognizer*)sender{
    NSLog(@"我成功的触发了屏幕边缘手势");
}

/**
 长按手势
 */
- (void)longPressGestureMethod {
    // ⑥长按手势
    UILongPressGestureRecognizer *longPressPR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    longPressPR.minimumPressDuration = 1;
    [self.gestureView addGestureRecognizer:longPressPR];
}

//长按手势的回调方法
- (void)longPressAction:(UILongPressGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateEnded) {

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"看你麻痹" message:@"不服你咬死我" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];

    }
}

/**
 轻扫手势
 */
- (void)swipeGestureMethod {

    UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];

    [self.gestureView addGestureRecognizer:swipeGR];
}

// 轻扫手势的回调方法
- (void)swipeAction:(UISwipeGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateEnded) {
        TJLog(@"轻扫手势");
    }
}

/**
 *  多个手势同时存在的代理,不能忘记
 */
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{

    return YES;
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
