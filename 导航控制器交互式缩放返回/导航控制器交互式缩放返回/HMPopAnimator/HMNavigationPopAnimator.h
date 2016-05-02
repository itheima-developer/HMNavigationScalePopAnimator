//
//  HMNavigationPopAnimator.h
//  导航控制器交互式缩放返回
//
//  Created by 刘凡 on 16/5/2.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 交互式 POP 转场代理动画器
@interface HMNavigationPopAnimator : NSObject <UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate>

/// 使用导航控制器实例化 POP 转场动画器
///
/// @param nav          导航控制器
/// @param parentView   父视图截图
/// @param tabBarHidden 是否隐藏 TabBar
///
/// @return POP 转场动画器
- (instancetype)initWithNavigationController:(UINavigationController *)nav parentView:(UIView *)parentView tabBarHidden:(BOOL)tabBarHidden;

@end
