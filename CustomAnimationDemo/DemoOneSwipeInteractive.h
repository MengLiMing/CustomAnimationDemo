//
//  DemoOnePresentInteractive.h
//  CustomAnimationDemo
//
//  Created by my on 16/3/30.
//  Copyright © 2016年 base. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoOneSwipeInteractive : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;//是否在切换过程中

- (void)wireToViewController:(UIViewController *)viewController;

@end
