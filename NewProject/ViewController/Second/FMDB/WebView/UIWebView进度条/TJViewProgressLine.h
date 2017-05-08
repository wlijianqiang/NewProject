//
//  TJViewProgressLine.h
//  NewProject
//
//  Created by lijianqiang on 2017/5/8.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJViewProgressLine : UIView
/**进度条颜色*/
@property (nonatomic, strong)UIColor *lineColor;

/**开始加载*/
- (void)startLoadingAnimation;

/**结束加载*/
- (void)endLoadingAnimation;
@end
