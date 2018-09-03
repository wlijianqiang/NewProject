//
//  TJFourViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/16.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJFourViewController.h"
#import "TJTableViewHeaderView.h"
//#import <Photos/PHPhotoLibrary.h>
#import "TJFourViewController+HeaderView.h"

typedef NS_ENUM(NSInteger,CellIndexPath){
    CellIndexPath_ImagePickerView = 0,
};

@interface TJFourViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>

@property(nonatomic,strong)UITableView *tableView;

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
    [self addTableViewHeaderView];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    if (CellIndexPath_ImagePickerView == indexPath.row) {
//        cell.textLabel.text = @"图片选择器";
//    }else{
//        cell.textLabel.text = kRandomData;
//    }
     cell.textLabel.text = kRandomData;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case CellIndexPath_ImagePickerView:
        {
            [JLRoutes routeURL:[NSURL URLWithString:@"/TJImagePickerViewController"] withParameters:nil];

        }
            break;
            
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
