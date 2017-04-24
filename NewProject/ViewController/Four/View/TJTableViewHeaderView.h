//
//  TJTableViewHeaderView.h
//  NewProject
//
//  Created by lijianqiang on 2017/3/3.
//  Copyright © 2017年 STV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  TJTableViewHeaderView;

@protocol TJTableViewHeaderViewDelegate <NSObject>

- (void)tableViewHeaderView:(TJTableViewHeaderView *)tableViewHeaderView centerImageView:(UITapGestureRecognizer *)sender;

@end

@interface TJTableViewHeaderView : UIView

@property (nonatomic, copy)UIImage *headerImage;
@property (nonatomic, weak)id<TJTableViewHeaderViewDelegate> delegate;

- (void)tableViewHeaderViewReload;

@end
