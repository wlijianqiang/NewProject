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
    [self addTableView];
}

- (void)addTableView{

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self viewRefresh];
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
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cornerRadius = 5.0f;
    //创建路径
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGRect bounds = CGRectInset(cell.bounds, 10, 5);//该结构体的应用是以原rect为中心，再参考dx，dy，进行缩放或者放大
    /*CG_EXTERN void CGPathMoveToPoint(CGMutablePathRef cg_nullable path,
    const CGAffineTransform * __nullable m, CGFloat x, CGFloat y)
    CG_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_2_0);*/
    if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
    } else if (indexPath.row == 0) {
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
    } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
    } else {
        //CGPathAddRect(pathRef, nil, bounds);
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds)-1);
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds)-1);
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
    }

    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = pathRef;
    CFRelease(pathRef);
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.strokeColor = [UIColor lightGrayColor].CGColor;
    layer.lineWidth = .5;
    
    UIView *viewBg = [[UIView alloc] initWithFrame:bounds];
    [viewBg.layer insertSublayer:layer atIndex:0];
    viewBg.backgroundColor = UIColor.clearColor;
    cell.backgroundView = viewBg;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = kRandomData;
    return cell;
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
