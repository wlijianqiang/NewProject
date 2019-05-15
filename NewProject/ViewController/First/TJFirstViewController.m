//
//  TJFirstViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/16.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJFirstViewController.h"
#import "UITabBar+TJBadge.h"
#import "TJFirstViewController+CycleScrollView.h"

#import "SRWebSocket.h"
#import <objc/runtime.h>

@interface TJFirstViewController ()<SRWebSocketDelegate>

@property (nonatomic, strong)SRWebSocket *webSocket;

@end

@implementation TJFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    [self addCycleScrollView];
    //显示红点
    [self.tabBarController.tabBar showBadgeOnItemIndex:0];
    TJLog(@"%@",NSStringFromClass([self class]));
    
    [self reconnect];

    
    UIImage *image = [self createImageWithColor:[UIColor colorWithHexString:@"789098"]];

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [self circleImageWithImage:image borderWidth:1 borderColor:[UIColor redColor]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.left.mas_equalTo(50);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
}

#pragma mark - 生成一个待圆角的图片
- (UIImage *)circleImageWithImage:(UIImage *)oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 10 * borderWidth;
    CGFloat imageH = oldImage.size.height + 10 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);

    // 3.取得当前的上下文,这里得到的就是上面刚创建的那个图片上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆。As a side effect when you call this function, Quartz clears the current path.

    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);

    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];

    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    // 8.结束上下文
    UIGraphicsEndImageContext();

    return newImage;
}

#pragma mark - 把颜色转变成为图片
- (UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0,0,15,15);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)reconnect{
    self.webSocket.delegate = nil;
    [self.webSocket close];
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://echo.websocket.org"]]];
    self.webSocket.delegate = self;
    [self.webSocket open];
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    
}

- (IBAction)hiddenBadgeAction:(UIButton *)sender {
    //隐藏红点
    //[self.tabBarController.tabBar hiddenBadgeOnItemIndex:0];
    [JLRoutes routeURL:[NSURL URLWithString:@"/testViewController"] withParameters:nil];

}

-(void)dealloc {
    [[TJAPIManager shareManager]cancelAllOperations ];
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
