//
//  TJFourViewController+HeaderView.m
//  NewProject
//
//  Created by lijianqiang on 2017/4/27.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJFourViewController+HeaderView.h"

@implementation TJFourViewController (HeaderView)

- (void)addTableViewHeaderView{
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
    }else{
        [self showHint:@"未检测到相机！请使用真机测试"];
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


@end
