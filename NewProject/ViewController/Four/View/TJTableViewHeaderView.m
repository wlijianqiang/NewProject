//
//  TJTableViewHeaderView.m
//  NewProject
//
//  Created by lijianqiang on 2017/3/3.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJTableViewHeaderView.h"

@interface TJTableViewHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *centerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation TJTableViewHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    [super layoutSubviews];
    self.centerImageView.layer.cornerRadius = self.centerImageView.frame.size.width/2;
    if (self.headerImage) {
        self.centerImageView.image = self.headerImage;
        self.backgroundImageView.image = self.headerImage;
    }
}

-(void)tableViewHeaderViewReload{
    [self layoutSubviews];
}

- (IBAction)centerImageView:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(tableViewHeaderView:centerImageView:)]) {
        [self.delegate tableViewHeaderView:self centerImageView:sender];
    }
}

@end
