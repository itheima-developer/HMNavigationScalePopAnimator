//
//  HMNavigationPopAnimator.m
//  导航控制器交互式缩放返回
//
//  Created by 刘凡 on 16/5/2.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMNavigationPopAnimator.h"

@implementation HMNavigationPopAnimator {
    __weak UINavigationController *_navigationController;
    UIView *_parentSnapView;
    BOOL _tabBarHidden;
    
    UIPercentDrivenInteractiveTransition *_popInteractiveAnimator;
}

- (instancetype)initWithParentView:(UIView *)parentView tabBarHidden:(BOOL)tabBarHidden; {
    
    self = [super init];
    if (self) {
        _parentSnapView = parentView;
        _tabBarHidden = tabBarHidden;
    }
    return self;
}

- (void)setNavigationControllerDelegate:(UINavigationController *)navigationController {
    _navigationController = navigationController;
    
    UIScreenEdgePanGestureRecognizer *screenPanRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleScreenEdgePan:)];
    screenPanRecognizer.edges = UIRectEdgeLeft;
    [_navigationController.view addGestureRecognizer:screenPanRecognizer];
    
    _navigationController.delegate = self;
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - 监听方法
- (void)handleScreenEdgePan:(UIScreenEdgePanGestureRecognizer *)recognizer {
    
    UIView *view = recognizer.view;
    CGPoint translation = [recognizer translationInView:view];
    CGFloat progress = translation.x / view.bounds.size.width;
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            _popInteractiveAnimator = [[UIPercentDrivenInteractiveTransition alloc] init];
            [_navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            [_popInteractiveAnimator updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
            if (progress >= 0.5) {
                [_popInteractiveAnimator finishInteractiveTransition];
            } else {
                [_popInteractiveAnimator cancelInteractiveTransition];
            }
            
            _popInteractiveAnimator = nil;
            break;
        default:
            break;
    }
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPop) {
        return self;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if (animationController == self) {
        return _popInteractiveAnimator;
    }
    return nil;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    _navigationController.navigationBar.hidden = YES;
    UITabBarController *tabBarController = nil;
    if ([_navigationController.parentViewController isKindOfClass:[UITabBarController class]]) {
        tabBarController = (UITabBarController *)_navigationController.parentViewController;
    }
    tabBarController.tabBar.hidden = YES;
    
    UIView *containerView = [transitionContext containerView];
    
    _parentSnapView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    [containerView addSubview:_parentSnapView];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromDummyView = [fromVC.navigationController.view snapshotViewAfterScreenUpdates:NO];
    
    [containerView addSubview:fromDummyView];
    fromVC.view.hidden = YES;
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        _parentSnapView.transform = CGAffineTransformIdentity;
        fromDummyView.transform = CGAffineTransformTranslate(fromDummyView.transform, fromDummyView.bounds.size.width, 0);
    } completion:^(BOOL finished) {
        [_parentSnapView removeFromSuperview];
        [fromDummyView removeFromSuperview];
        
        if (transitionContext.transitionWasCancelled) {
            fromVC.view.hidden = NO;
        } else {
            [containerView addSubview:toView];
            [fromVC.view removeFromSuperview];
        }
        
        _navigationController.navigationBar.hidden = NO;
        tabBarController.tabBar.hidden = _tabBarHidden;
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
