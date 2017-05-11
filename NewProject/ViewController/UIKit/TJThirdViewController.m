//
//  TJThirdViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/16.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJThirdViewController.h"
#import "TJThirdViewController+pushViewController.h"

typedef NS_ENUM(NSInteger, IndexPathSection) {
    IndexPathSection_AlertView = 0,
    IndexPathSection_TableView,
    IndexPathSection_CollectionView,
    IndexPathSection_Orientation,
    IndexPathSection_Media,
};

@interface TJThirdViewController ()<UITableViewDelegate,UITableViewDataSource>

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

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)DataForTableView{
    self.sectionTitleMutableArray = [NSMutableArray arrayWithObjects:
                                     @"弹出框",
                                     @"tableView",
                                     @"collectionView",
                                     @"Orientation",
                                     @"Media",
                                     nil];
    self.dataMutableArray = [NSMutableArray arrayWithObjects:
                              @[@"系统默认样式",@"xib自定义弹出框"],
                              @[@"tableView描边"],
                              @[@"collectionView(代码)",@"collectionView(Storyboard)",@"图片选择器"],
                              @[@"程序旋转方向"],
                              @[@"AboutAudioToolbox",@"audioRecorder",@"foundationCamera",@"foundationCmeraRecord"],
                              nil];
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
       [JLRoutes routeURL:[NSURL URLWithString:@"/TJStrockViewController"] withParameters:nil];
    }else if (IndexPathSection_CollectionView == indexPath.section){
        [self showCollectionViewForRow:indexPath.row];
    }else if (indexPath.section == IndexPathSection_Orientation){
        [JLRoutes routeURL:[NSURL URLWithString:@"/TJOrientationViewController"]];
    }else if (indexPath.section == IndexPathSection_Media){
        if (0 == indexPath.row) {
            [JLRoutes routeURL:[NSURL URLWithString:@"/TJAudioViewController"]];
        }else if (1 == indexPath.row){
            [JLRoutes routeURL:[NSURL URLWithString:@"/TJAudioRecorderViewController"]];
        }else if (2 == indexPath.row){
            [JLRoutes routeURL:[NSURL URLWithString:@"/TJFoundationCameraViewController"]];
        }else if (3 == indexPath.row){
            [JLRoutes routeURL:[NSURL URLWithString:@"/TJFoundationCameraRecordingViewController"] withParameters:nil];
            
        }
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
