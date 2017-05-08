//
//  TJWKWebViewViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/5/8.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJWKWebViewViewController.h"
#import <WebKit/WebKit.h> //ios 8才有的框架

@interface TJWKWebViewViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong)WKWebView *webView;
@property (nonatomic, strong)UIProgressView *progressView;

@end

@implementation TJWKWebViewViewController

-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView setNavigationDelegate:nil];
    [self.webView setUIDelegate:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addWKWebView];
}

- (void)addWKWebView{
    
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    

    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 2)];
    self.progressView.trackTintColor = [UIColor redColor];
    [self.view addSubview:self.progressView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    TJLog(@" %s,change = %@",__FUNCTION__,change)
    if ([keyPath isEqualToString:@"estimatedProgress"] && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        if (self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setProgress:0.0f];
                //self.progressView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
                [self.progressView removeFromSuperview];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - WKNavigationDelegate

//发送请求之前 决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    TJLog(@"%s  %@",__func__,@"发送请求之前 决定是否跳转");
    if ([navigationAction.request.URL.host.lowercaseString isEqualToString:@"www.baidu.com"]) {
        
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    // 不允许跳转
    decisionHandler(WKNavigationActionPolicyCancel);
}

/**
 *  页面开始加载时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    TJLog(@"%s  %@",__func__,@"页面开始加载");
}

//收到响应后是否决定跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    TJLog(@"%s  %@",__func__,@"收到响应后是否决定跳转");
    //相应地址为百度才允许跳转
    if ([navigationResponse.response.URL.host.lowercaseString isEqualToString:@"www.baidu.com"]) {
        //允许跳转
        decisionHandler(WKNavigationResponsePolicyAllow);
        return;
    }
    //不允许跳转
    decisionHandler(WKNavigationResponsePolicyCancel);
}

// 内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    TJLog(@"%s  %@",__func__,@"内容开始返回时调用");
}
//页面加载完成后
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    TJLog(@"%s  %@",__func__,@"页面加载完成后");
}

//页面加载失败
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    TJLog(@"%s  %@",__func__,@"页面加载失败");
}

//接受到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    TJLog(@"%s  %@",__func__,@"接受到服务器跳转请求之后调用");
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
