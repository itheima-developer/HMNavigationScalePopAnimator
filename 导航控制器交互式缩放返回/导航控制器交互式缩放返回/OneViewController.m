//
//  OneViewController.m
//  003-自定义导航控制器进阶
//
//  Created by 刘凡 on 16/5/1.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "OneViewController.h"
#import "TwoViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"第1个";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"第2个" style:UIBarButtonItemStylePlain target:self action:@selector(clickNextButton)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 监听方法
- (void)clickNextButton {    
    TwoViewController *vc = [[TwoViewController alloc] init];
    
    vc.hidesBottomBarWhenPushed = YES;
    vc.parentView = [self.navigationController.view snapshotViewAfterScreenUpdates:YES];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
