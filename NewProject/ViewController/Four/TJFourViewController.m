//
//  TJFourViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/1/16.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJFourViewController.h"
#import "TJTableViewHeaderView.h"
#import <Photos/PHPhotoLibrary.h>

@interface TJFourViewController ()<UITableViewDelegate,UITableViewDataSource,TJTableViewHeaderViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

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

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cameraAction];
    [alertController addAction:photoLibraryAction];
    [alertController addAction:cancleAction];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
    
}

- (void)takePhoto{
   /* PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    //表明用户尚未选择关于客户端是否可以访问硬件
    AVAuthorizationStatusNotDetermined = 0,
    // 客户端未被授权访问硬件的媒体类型。用户不能改变客户机的状态,可能由于活跃的限制,如家长控制
    AVAuthorizationStatusRestricted,
    // 明确拒绝用户访问硬件支持的媒体类型的客户
    AVAuthorizationStatusDenied,
    // 客户端授权访问硬件支持的媒体类型
    AVAuthorizationStatusAuthorized     
     */
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (granted) {
                    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
                }else{
                    // 无相机权限 做一个友好的提示
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
                    }];
                    UIAlertAction *setupAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    }];
                    [alertController addAction:cancelAction];
                    [alertController addAction:setupAction];
                    [self presentViewController:alertController animated:YES completion:^{
                        
                    }];
                }
            }];
        }];
    }

}

#pragma mark - UIImagePickerController

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePickerController.showsCameraControls = YES;
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])
        {
            imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        [self.view.window.rootViewController presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        [self.view.window.rootViewController presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.navigationController.navigationBarHidden = YES;
    UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.headrView.headerImage = image;
    [self.headrView tableViewHeaderViewReload];
    [picker dismissViewControllerAnimated:YES completion:^(){
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    self.navigationController.navigationBarHidden = YES;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        
        self.headrView.frame = CGRectMake(offsetY/2, 0, self.view.frame.size.width - offsetY, 150.0 - offsetY);
    }else{
        self.headrView.frame = CGRectMake(0, - offsetY, self.view.frame.size.width, 150.0);
        
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = kRandomData;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
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
