//
//  JQRunLoopViewController.m
//  NewProject
//
//  Created by lijianqiang on 2018/8/31.
//  Copyright © 2018年 STV. All rights reserved.
//

#import "JQRunLoopViewController.h"

@interface JQRunLoopViewController ()

@end

@implementation JQRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor defaultColor];
    [self runLoopTest];
}

- (void)timerFire {
    TJLog(@"model:%@",[[NSRunLoop currentRunLoop] currentMode]);
}
- (void)runLoopTest {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSTimer *tickTimer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:2 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:tickTimer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    });
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
