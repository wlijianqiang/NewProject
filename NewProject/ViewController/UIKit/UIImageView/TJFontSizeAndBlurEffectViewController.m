//
//  TJFontSizeAndBlurEffectViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/5/12.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJFontSizeAndBlurEffectViewController.h"

@interface TJFontSizeAndBlurEffectViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation TJFontSizeAndBlurEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"高斯模糊";
    self.imageView = [UIImageView imageVIew:self.imageView visualEffectViewFrame:self.imageView.frame alpha:0.8];
    [self addTableView];
}

- (void)addTableView{
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.imageView.frame.size.height);
        make.width.mas_equalTo(kMainScreenWidth);
        make.height.mas_equalTo(kMainScreenHeight - self.imageView.frame.size.height);
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"---self.tableView.contentOffset.y value is %f---",self.tableView.contentOffset.y);
    int x = (int)self.tableView.contentOffset.y / 10;
    if (x < 0) {
        x = 8;
    }
    NSLog(@"x is %d",x);
    
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:8+x],NSFontAttributeName, nil] forState:UIControlStateNormal];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
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
