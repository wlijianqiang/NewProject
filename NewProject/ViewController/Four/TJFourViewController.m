//
//  TJFourViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/16.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJFourViewController.h"
#import "TJTableViewHeaderView.h"

@interface TJFourViewController ()<UITableViewDelegate,UITableViewDataSource,TJTableViewHeaderViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic, strong)TJTableViewHeaderView *headrView;

@end

@implementation TJFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的";
    [self setSubViews];
}

- (void)setSubViews{
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 150.0f)];
    
    self.headrView = [TJTableViewHeaderView loadFromNib];
    self.headrView.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 150.0f);
    self.headrView.delegate = self;
    [self.view addSubview:self.headrView];
}
#pragma mark - TJTableViewHeaderViewDelegate
-(void)tableViewHeaderView:(TJTableViewHeaderView *)tableViewHeaderView centerImageView:(UITapGestureRecognizer *)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iconClicked"
                                                    message:@"修改头像"
                                                   delegate:nil
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确认",nil];
    [alert show];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = kRandomData;
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        
        self.headrView.frame = CGRectMake(offsetY/2, 0, self.view.frame.size.width - offsetY, 150.0 - offsetY);
    }else{
        self.headrView.frame = CGRectMake(0, - offsetY, self.view.frame.size.width, 150.0);
        
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
