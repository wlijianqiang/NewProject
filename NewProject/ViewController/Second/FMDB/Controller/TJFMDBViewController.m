//
//  TJFMDBViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/3/6.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJFMDBViewController.h"

typedef NS_ENUM(NSInteger, ButtonTag) {
    ButtonTag_Create = 1001,
    ButtonTag_Insert,
    ButtonTag_Query,
    ButtonTag_Drop,
};

@interface TJFMDBViewController ()

@property (nonatomic, strong)FMDatabase *database;

@property (nonatomic, strong)FMDBMigrationManager *manager;
@end

@implementation TJFMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)buttonAction:(UIButton *)sender {
    switch (sender.tag) {
        case ButtonTag_Create:
        {
            [self createTable];
        }
            break;
        case ButtonTag_Insert:
        {
            [self insertData];
        }
            break;
        case ButtonTag_Query:
        {
            [self query];
        }
            break;
        case ButtonTag_Drop:
        {
            //[self.db executeUpdate:@"DELETE FROM t_student;"];//删除student表中所有数据
            [self.database executeUpdate:@"DROP TABLE IF EXISTS t_student;"];//删除student表
        }
            break;
    }
}

- (void)createTable{
    
    NSString *fileName = [kPathDocument stringByAppendingString:@"/student.sqlite"];
    NSLog(@"%@",fileName);
    //获取数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    
    if ([db open]) {//打开数据库
        //创表
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
        if (result)
        {
            [self showHint:@"创建表成功"];
            
        }else{
            [self showHint:@"创建表失败"];
        }
    }
    self.database = db;

}

- (void)insertData{
    for (int i = 0; i<10; i++) {
        NSString *name = [NSString stringWithFormat:@"test-%d", arc4random_uniform(100)];
        // executeUpdate : 不确定的参数用?来占位
        [self.database executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);", name, @(arc4random_uniform(40))];
    }
}

- (void)query{
    //执行查询语句
    FMResultSet *resultSet = [self.database executeQuery:@"SELECT * FROM t_student"];
    //遍历结果
    while ([resultSet next]) {
        int ID  = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet stringForColumn:@"name"];
        int age = [resultSet intForColumn:@"age"];
        NSLog(@"id is %d name is %@ age is %d",ID,name,age);
    }
    
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
