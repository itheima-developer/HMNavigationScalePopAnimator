//
//  AppDelegate.m
//  导航控制器交互式缩放返回
//
//  Created by 刘凡 on 16/5/2.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "AppDelegate.h"
#import "OneViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor redColor];
    
    OneViewController *vc = [[OneViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.view.backgroundColor = [UIColor lightGrayColor];
    
    UITabBarController *tab = [[UITabBarController alloc] init];
    tab.viewControllers = @[nav];
    
    _window.rootViewController = tab;
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
