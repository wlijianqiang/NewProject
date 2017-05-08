//
//  TJWebviewProgressLineViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/5/8.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJWebviewProgressLineViewController.h"
#import "TJViewProgressLine.h"

@interface TJWebviewProgressLineViewController ()<UIWebViewDelegate>

@property (nonatomic, strong)TJViewProgressLine *progressLine;
@property (nonatomic, strong)UIWebView *webView;

@end

@implementation TJWebviewProgressLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addWebView];
}

- (void)addWebView{
    
    self.view.backgroundColor = [UIColor defaultColor];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    self.progressLine = [[TJViewProgressLine alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 3)];
    self.progressLine.lineColor = [UIColor redColor];
    [self.view addSubview: self.progressLine];
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.progressLine startLoadingAnimation];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.progressLine endLoadingAnimation];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.progressLine endLoadingAnimation];
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
