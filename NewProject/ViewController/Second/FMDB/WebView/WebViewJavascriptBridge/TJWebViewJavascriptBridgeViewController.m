//
//  TJWebViewJavascriptBridgeViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/5/9.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJWebViewJavascriptBridgeViewController.h"
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>

@interface TJWebViewJavascriptBridgeViewController ()

@property (nonatomic, strong)WKWebView *webView;
@property (nonatomic, strong)WebViewJavascriptBridge *bridge;

@end

@implementation TJWebViewJavascriptBridgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self webViewJavascriptBridge];
}

- (void)webViewJavascriptBridge{
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    if (_bridge) {return;}else{
        [WebViewJavascriptBridge enableLogging];
        self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
        [self.bridge setWebViewDelegate:self];
    }
    
    //请求加载html 注意：这里h5加载完，会执行调用一个oc的方法
    [self loadExamplePage:self.webView];
    //申明js调用oc方法的处理事件，这里写了后，h5那边只要请求 oc内部就会响应
    [self JSToOC];
    
    //模拟操作 3秒后 oc会调用js方法
    //注意：特别的是 我们不需要等待html加载完成，就能处理oc的请求事件，此外，webview的request 也可以在这个请求后面执行（也可以把[self loadExamplePage:self.webView]放到[self OCTOJS]后面执行，结果一样）
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self OCTOJS];
    });
}
/**JS调用OC*/
- (void)JSToOC{
    /**
     含义：JS调用OC
     @param registerHandler 要注册事件的名称
     @param handler 回调block函数 当后台触发这个事件的时候会执行block里的代码
     */
    [self.bridge registerHandler:@"loginAction" handler:^(id data, WVJBResponseCallback responseCallback) {
        //data js页面传过来的参数 字典格式
        TJLog(@"JS调用OC，并传值过来");
        
        NSDictionary *dict = (NSDictionary *)data;
        NSString *str = [NSString stringWithFormat:@"用户名：%@ 姓名:%@",dict[@"userId"],dict[@"name"]];
        [self rendButton:str];
        [self showHint:[NSString stringWithFormat:@"用户名：%@ 姓名:%@",dict[@"userId"],dict[@"name"]]];
        //responseCallback 给后台的回复
        responseCallback(@"oc 已收到js的请求！");
    }];
}
/**OC调用JS*/
- (void)OCTOJS{
    /**
     含义：OC调用JS
     @param callHandler 商定的事件名称，用来调用网页里相应的事件实现
     @param data id类型,相当于我们函数中的参数,向网页传递函数执行需要的参数
     注意，这里callHandler分3种，根据需不需要传参数和需不需要后台返回执行结果来决定用哪个
     */
    [self.bridge callHandler:@"registerAction" data:@"uid:123, pwd:234" responseCallback:^(id responseData) {
        NSLog(@"oc请求js后接受的回调结果：%@",responseData);
    }];
}
- (void)rendButton:(NSString *)string{
    NSLog(@"JS调用OC,渠道的参数为：%@",string);
}

- (void)disableSafetyTimeout{
    [self.bridge disableJavscriptAlertBoxSafetyTimeout];
}
- (void)loadExamplePage:(WKWebView *)webView{
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString *appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseUrl = [NSURL fileURLWithPath:htmlPath];
    [webView loadHTMLString:appHtml baseURL:baseUrl];
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
