//
//  SpreadModelViewController.m
//  CustomAnimationDemo
//
//  Created by my on 16/4/2.
//  Copyright © 2016年 base. All rights reserved.
//

#import "SpreadModelViewController.h"

#import "PureLayout.h"

#import "SpreadAnimation.h"
#import "AlphaPanManager.h"


@interface SpreadModelViewController ()

@property (nonatomic, strong) AlphaPanManager *dismissManager;

@end

@implementation SpreadModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    UIImageView *imageView = [UIImageView newAutoLayoutView];
    [imageView setImage:[UIImage imageNamed:@"pageOne"]];
    [self.view addSubview:imageView];
    [imageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [imageView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [imageView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [imageView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    [button setTitle:@"点我或向下滑动dismiss" forState:UIControlStateNormal];
    [button autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    [button autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [button autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [button autoSetDimension:ALDimensionHeight toSize:40];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    
    _dismissManager = [AlphaPanManager managerWithDirection:AlphaPanManagerGestureDirectionDown type:AlphaPanManagerTypeDismiss];
    [_dismissManager addPanGestureToVC:self];
}


- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [SpreadAnimation animationWithType:SpreadAnimationTypePresent];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [SpreadAnimation animationWithType:SpreadAnimationTypeDismiss];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return _dismissManager.interactiving ? _dismissManager : nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
