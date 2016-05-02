//
//  ThreeViewController.m
//  003-自定义导航控制器进阶
//
//  Created by 刘凡 on 16/5/2.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ThreeViewController.h"
#import "HMNavigationPopAnimator.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController {
    HMNavigationPopAnimator *_popAnimator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"第3个";
    
    _popAnimator = [[HMNavigationPopAnimator alloc] initWithParentView:_parentView tabBarHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_popAnimator setNavigationControllerDelegate:self.navigationController];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.navigationController.delegate == _popAnimator) {
        self.navigationController.delegate = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
