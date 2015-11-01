//
//  RootViewController.m
//  NSinvocation练习
//
//  Created by mac on 15-10-27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "RootViewController.h"
#import "MyModel.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    MyModel *model = [[MyModel alloc]init];
    model.name = @"张三";
    model.age = 13;
    model.address = @"北京海淀区";
    [NSKeyedArchiver archivedDataWithRootObject:model];
    MyModel *model2 = [model copy];
    NSLog(@"*****%@",model2);
    NSLog(@"*****%@",model2);
    NSLog(@"*****%@",model2);
    NSLog(@"*****%@",model2);

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
