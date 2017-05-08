//
//  TJWebListTableViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/5/8.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJWebListTableViewController.h"

@interface TJWebListTableViewController ()

@property (nonatomic, strong)NSMutableArray *dataMutableArray;

@end

@implementation TJWebListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    self.dataMutableArray = [NSMutableArray arrayWithObjects:@"UIWebView进度条",@"WKWebView", nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataMutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = [NSString stringWithFormat: @"%@",self.dataMutableArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row) {
        [JLRoutes routeURL:[NSURL URLWithString:@"/TJWebviewProgressLineViewController"] withParameters:nil];
    }else if (1 == indexPath.row){
        [JLRoutes routeURL:[NSURL URLWithString:@"/TJWKWebViewViewController"] withParameters:nil];
    }
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
