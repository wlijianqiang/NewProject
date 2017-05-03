//
//  TJTestViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/22.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJTestViewController.h"

#import "IQTextView.h"

@interface TJTestViewController ()

@end

@implementation TJTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"test";
   
    UITextView *textView = [[UITextView alloc] init];
   // textView.placeholder = @"placeholder";
    textView.backgroundColor = [UIColor redColor];
    [self.view addSubview:textView];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(kMainScreenWidth - 20);
        make.height.mas_equalTo(200);
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
