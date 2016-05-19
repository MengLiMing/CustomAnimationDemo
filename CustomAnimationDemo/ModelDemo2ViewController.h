//
//  ModelDemo2ViewController.h
//  CustomAnimationDemo
//
//  Created by my on 16/3/30.
//  Copyright © 2016年 base. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModelDemo2ViewControllerDelegate <NSObject>

- (void)clickButtonAndDismissViewController:(UIViewController *)viewController;

@end

@interface ModelDemo2ViewController : UIViewController

@property (nonatomic, weak) id<ModelDemo2ViewControllerDelegate>delegate;

@end
