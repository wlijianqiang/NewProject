//
//  TJStoryboardCollectionViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/4/25.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJStoryboardCollectionViewController.h"
#import "TJCollectionViewCell.h"
#import "TJCollectionHeaderReusableView.h"
#import "TJCollectionFooterReusableView.h"

@interface TJStoryboardCollectionViewController ()

@end

@implementation TJStoryboardCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 18;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TJCollectionViewCell class]) forIndexPath:indexPath];
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = nil ;
    
    if (kind == UICollectionElementKindSectionHeader ){
        
        TJCollectionHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind : UICollectionElementKindSectionHeader withReuseIdentifier : NSStringFromClass([TJCollectionHeaderReusableView class]) forIndexPath :indexPath];
        
        reusableview = headerView;
        
    }
    
    if (kind == UICollectionElementKindSectionFooter){
        
        TJCollectionFooterReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([TJCollectionFooterReusableView class]) forIndexPath:indexPath];
        reusableview = footerview;
        
    }
    
    return reusableview;
    
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
