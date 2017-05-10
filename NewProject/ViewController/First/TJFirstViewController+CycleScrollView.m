//
//  TJFirstViewController+CycleScrollView.m
//  NewProject
//
//  Created by lijianqiang on 2017/4/27.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJFirstViewController+CycleScrollView.h"

@implementation TJFirstViewController (CycleScrollView)

- (void)addCycleScrollView{
    
    [self cycleScrollViewData];
    
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleScrollView.titlesGroup = self.bannerTitleArray;
    self.cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    self.cycleScrollView.autoScrollTimeInterval = 3.0f;
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.cycleScrollView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cycleScrollView.imageURLStringsGroup = self.bannerImageUrlArray;
    });
    
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        //make.width.mas_equalTo(kMainScreenWidth);
        make.height.mas_equalTo(150);
    }];
    
}

- (void)cycleScrollViewData{
    self.bannerImageUrlArray = @[
                                 @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                 @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                 @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                                 ];
    self.bannerTitleArray = @[@"测试页面 -1",
                              @"测试页面 -2",
                              @"测试页面 -3",
                              @"测试页面 -4"
                              
];
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"---点击了第%ld张图片", (long)index);
    NSString *imageUrl = cycleScrollView.imageURLStringsGroup[index];
    [JLRoutes routeURL:[NSURL URLWithString:@"/TJWKUserScriptViewController"] withParameters:@{@"imageUrl":imageUrl }];
    
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
     //NSLog(@">>>>>> 滚动到第%ld张图", (long)index);
}

@end
