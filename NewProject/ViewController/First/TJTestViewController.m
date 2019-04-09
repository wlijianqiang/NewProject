//
//  TJTestViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/22.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJTestViewController.h"
#import <WebKit/WebKit.h>
#import "IQTextView.h"

@interface TJTestViewController ()<WKNavigationDelegate>

@property (nonatomic ,strong)WKWebView *webView;
@property (nonatomic ,strong)UITextView *textView;

@end

@implementation TJTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"路由跳转进 WKWebView 加载进度条";
    [self addWebView];
//    [self addTextView];
    
    
    
}
//-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //跳出app打开网页
//    if ([webView.URL.absoluteString hasPrefix:@"https://www.baidu.com"]) {
//        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
//        decisionHandler(WKNavigationActionPolicyCancel);
//    }else {//app内打开网页
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
//}
#pragma mark 取消监听
-(void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
#pragma mark wkwebview 进度条
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newProgress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.textView.text = [NSString stringWithFormat:@"%.0f",newProgress];
        [self showHint:[NSString stringWithFormat:@"网页加载百分比：%.0f%%",newProgress*100]];
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)addWebView {
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(10, 10, kMainScreenWidth - 20, kMainScreenHeight - 20)];
    self.webView.navigationDelegate = self;
    //是否透明
    self.webView.opaque = NO;
    //多触点
    self.webView.multipleTouchEnabled = YES;
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}
- (void)addTextView {
    self.textView = [[UITextView alloc] init];
    // textView.placeholder = @"placeholder";
    self.textView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(kMainScreenWidth - 20);
        make.height.mas_equalTo(100);
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
