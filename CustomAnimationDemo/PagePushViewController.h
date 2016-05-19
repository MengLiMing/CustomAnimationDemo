//
//  PagePushViewController.h
//  CustomAnimationDemo
//
//  Created by my on 16/3/31.
//  Copyright © 2016年 base. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PagePushViewControllerDelegate <NSObject>

- (id<UIViewControllerInteractiveTransitioning>)animationManagerForPush;

@end
@interface PagePushViewController : UIViewController <UINavigationControllerDelegate>

@property (nonatomic, weak) id<PagePushViewControllerDelegate>delegate;

@end
