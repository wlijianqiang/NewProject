//
//  TJSecondViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/16.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJSecondViewController.h"

@interface TJSecondViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataMutableArray;

@end

@implementation TJSecondViewController
- (void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TJTabBarDidClickNotification object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"咨询";
    [self tabBarNotification];
    [self addTableViewData];
    [self addTableView];
}

- (void)addTableView{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

    [self viewRefresh];
}

- (void)addTableViewData{
    self.dataMutableArray  = [NSMutableArray arrayWithObjects:@"FMDB",@"WebView", nil];
}
- (void)viewRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
}
- (void)loadData{
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataMutableArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
//注意：tableView:cellForRowAtIndexPath:这个方法需要为每个cell调用一次，它应该快速的执行。所以你需要尽快的返回重用的cell的实例，所以数据绑定最好在tableView:willDisplayCell:forRowAtIndexPath:中进行。这个方法在显示cell之前会被调用 willDisplayCell在cell 在tableview展示之前就会调用，此时cell实例已经生成，所以不能更改cell的结构，只能是改动cell上的UI的一些属性（例如label的内容等）
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
     cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataMutableArray[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.row) {
        [JLRoutes routeURL:[NSURL URLWithString:@"/TJFMDBViewController"] withParameters:nil];
    }else if(1 == indexPath.row){
       [JLRoutes routeURL:[NSURL URLWithString:@"/TJWebListTableViewController"] withParameters:nil];
    }
}

- (void)tabBarNotification{
    //TabBarItem被重复点击时的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarClick) name:TJTabBarDidClickNotification object:nil];
}

- (void)tabBarClick{
    //控制器的view显示在最最前面
    if ([self.view isShowingOnKeyWindow]) {
    //执行刷新等相关操作
        [self viewRefresh];
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
