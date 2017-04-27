//
//  TJImagePickerViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/4/27.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJImagePickerViewController.h"

@interface TJImagePickerViewController ()
///<,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TZImagePickerControllerDelegate>

//@property (nonatomic, strong)UICollectionView *collectionView;


@end

@implementation TJImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"图片选择器";
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
