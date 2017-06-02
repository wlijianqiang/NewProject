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
    TJLog(@"test");
    
    TJLog(@"%@", kPathTemp);
    [self reconnect];
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
