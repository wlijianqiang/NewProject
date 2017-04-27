//
//  TJFirstViewController.h
//  NewProject
//
//  Created by lijianqiang on 2017/1/16.
//  Copyright © 2017年 STV. All rights reserved.
//


#import "TJBaseViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface TJFirstViewController : UIViewController<SDCycleScrollViewDelegate>

@property (nonatomic, strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic, assign) NSUInteger pageIndex;
@property (nonatomic, strong) NSArray *bannerImageUrlArray;
@property (nonatomic, strong) NSArray *bannerTitleArray;


@end
