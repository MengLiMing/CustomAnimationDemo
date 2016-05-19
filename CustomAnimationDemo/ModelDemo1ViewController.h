//
//  ModelDemo1ViewController.h
//  CustomAnimationDemo
//
//  Created by my on 16/3/30.
//  Copyright © 2016年 base. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ModelDemo1ViewController;

@protocol ModelDemo1ViewControllerDelegate <NSObject>

- (void)modelViewControllerDidClockedDismissbutton:(ModelDemo1ViewController *)viewController;

@end

@interface ModelDemo1ViewController : UIViewController

@property (nonatomic, weak) id<ModelDemo1ViewControllerDelegate> delegate;

@end
