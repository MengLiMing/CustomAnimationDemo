//
//  AppDelegate.m
//  CustomAnimationDemo
//
//  Created by my on 16/3/29.
//  Copyright © 2016年 base. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[BaseTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    
    
    //不可变数组，不可变拷贝
    NSArray *arr1 = @[@1,@2,@3];
    NSArray *arr2 = arr1;
    NSArray *arr3 = [arr1 copy];
    NSLog(@"%zd,%zd,%zd",&arr1,&arr2,&arr3);
    NSLog(@"%zd,%zd,%zd",arr1[0],arr2[0],arr3[0]);

    //不可变数组，可变拷贝
    NSArray *arr4 = @[@1,@2,@3];
    NSArray *arr5 = arr4;
    NSArray *arr6 = [arr4 mutableCopy];
    NSLog(@"-%zd,%zd,%zd",&arr4,&arr5,&arr6);
    NSLog(@"%zd,%zd,%zd",arr4[0],arr5[0],arr6[0]);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
