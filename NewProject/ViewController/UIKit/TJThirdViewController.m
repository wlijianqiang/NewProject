//
//  TJThirdViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/16.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJThirdViewController.h"
#import "TJCustomAlertView.h"

typedef NS_ENUM(NSInteger, IndexPathSection) {
    IndexPathSection_AlertView = 0,
    IndexPathSection_TableView,
    IndexPathSection_CollectionView,
};

@interface TJThirdViewController ()<UITableViewDelegate,UITableViewDataSource,TJCustomAlertViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataMutableArray;
@property (nonatomic, strong)NSMutableArray *sectionTitleMutableArray;
@end

@implementation TJThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"UIKit";
    [self DataForTableView];
    [self addMenuTableView];
}

- (void)addMenuTableView{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
}

- (void)DataForTableView{
    self.sectionTitleMutableArray = [NSMutableArray arrayWithObjects:@"弹出框",@"tableView",@"collectionView",nil];
    self.dataMutableArray = [NSMutableArray arrayWithObjects:
      @[@"系统默认样式",@"xib自定义弹出框"],
      @[@"tableView描边"],
      @[@"collectionView(代码)",@"collectionView(Storyboard)"],nil];
}
#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataMutableArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return [self.dataMutableArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *sectionLabel = [[UILabel alloc] init];
    sectionLabel.backgroundColor = [UIColor lightGrayColor];
    sectionLabel.text = [NSString stringWithFormat:@"  %@",self.sectionTitleMutableArray[section]];
    return sectionLabel;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataMutableArray[indexPath.section][indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (IndexPathSection_AlertView == indexPath.section) {
        [self showAltertViewForRow:indexPath.row];
    }else if (IndexPathSection_TableView == indexPath.section){
       [JLRoutes routeURL:[NSURL URLWithString:@"TJStrockViewController"] withParameters:nil];
    }else if (IndexPathSection_CollectionView == indexPath.section){
        [self showCollectionViewForRow:indexPath.row];
    }
}

- (void)showAltertViewForRow:(NSInteger )row{
    switch (row) {
        case 0:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题" message:@"这个是UIAlertController的默认样式" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            
            [alertController addAction:cancelAction];
            
            [alertController addAction:okAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case 1:
        {
            TJCustomAlertView *customAlertView = [TJCustomAlertView loadFromNib];
            customAlertView.frame = self.view.frame;
            customAlertView.delegate = self;
            [customAlertView customAlterViewForTitle:@"标题" message:@"不知所云"];
            [[UIApplication sharedApplication].keyWindow addSubview:customAlertView];
        }
            break;
    }
}

- (void)showCollectionViewForRow:(NSInteger )row{
    if (0 == row) {
        [JLRoutes routeURL:[NSURL URLWithString:@"TJCollectionViewController"] withParameters:nil];
    }else{
        [JLRoutes routeURL:[NSURL URLWithString:@"TJStoryboardCollectionViewController"] withParameters:nil];
    }
}
#pragma mark - TJCustomAlertViewDelegate
- (void)customAlertView:(TJCustomAlertView *)customAlertView cancleButton:(UIButton *)sender{
    [customAlertView dismiss];
}

- (void)customAlertView:(TJCustomAlertView *)customAlertView okButton:(UIButton *)sender{
     [customAlertView dismiss];
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
