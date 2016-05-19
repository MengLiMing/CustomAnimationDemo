//
//  ModelViewController.h
//  CustomAnimationDemo
//
//  Created by my on 16/3/31.
//  Copyright © 2016年 base. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModelViewControllerDelegate <NSObject>

- (void)dismissWhenClick:(UIViewController *)viewcontroller;

@end

@interface ModelViewController : UIViewController

@property (nonatomic, weak) id<ModelViewControllerDelegate>delegate;

@end
