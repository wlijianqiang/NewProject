//
//  TJWKUserScriptViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/5/9.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJWKUserScriptViewController.h"
#import <WebKit/WebKit.h>

#define HTML @"<head></head><img src='http://www.nsu.edu.cn/v/2014v3/img/background/3.jpg' />"

@interface TJWKUserScriptViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic, strong)WKWebView *webView;

@end

@implementation TJWKUserScriptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addWebView];
}

- (void)addWebView{
    //图片缩放的js代码
    NSString *js = @"var count = document.images.length;for (var i = 0; i < count; i++) {var image = document.images[i];image.style.width=320;};window.alert('找到' + count + '张图');";
    //根据生成的WKUserScript对象，初始化WKWebViewConfiguration
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    ///根据生成的WKUserScript对象，初始化WKUserViewConfiguration
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    [config.userContentController addUserScript:script];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    
    NSString *htmlStrings;
    if (self.imageUrl) {
        htmlStrings = [NSString stringWithFormat:@"<head></head><img src='%@' />",self.imageUrl];
    }else htmlStrings = @"<head></head><img src='http://www.nsu.edu.cn/v/2014v3/img/background/3.jpg' />";
    [self.webView loadHTMLString:htmlStrings baseURL:nil];
    [self.view addSubview:self.webView];
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
//从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    TJLog(@"%@", message);
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
