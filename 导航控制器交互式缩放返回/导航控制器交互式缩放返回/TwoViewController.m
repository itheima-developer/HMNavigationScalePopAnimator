//
//  TwoViewController.m
//  003-自定义导航控制器进阶
//
//  Created by 刘凡 on 16/5/1.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "HMNavigationPopAnimator.h"

@interface TwoViewController ()

@end

@implementation TwoViewController {
    /// POP 动画对象
    HMNavigationPopAnimator *_popAnimator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"第2个";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"第3个" style:UIBarButtonItemStylePlain target:self action:@selector(clickNextButton)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _popAnimator = [[HMNavigationPopAnimator alloc] initWithNavigationController:self.navigationController parentView:_parentView tabBarHidden:NO];
    self.navigationController.delegate = _popAnimator;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.navigationController.delegate == _popAnimator) {
        self.navigationController.delegate = nil;
    }
}

#pragma mark - 监听方法
- (void)clickNextButton {
    ThreeViewController *vc = [[ThreeViewController alloc] init];
    
    vc.hidesBottomBarWhenPushed = YES;
    vc.parentView = [self.navigationController.view snapshotViewAfterScreenUpdates:YES];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
