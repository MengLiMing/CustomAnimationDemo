//
//  CustomPopViewController.m
//  CustomAnimationDemo
//
//  Created by my on 16/4/6.
//  Copyright © 2016年 base. All rights reserved.
//

#import "CustomPopViewController.h"
#import "CustomNavAnimation.h"
#import "AlphaPanManager.h"

@interface CustomPopViewController () 

@property (nonatomic, strong) AlphaPanManager *popManager;
@property (nonatomic, assign) UINavigationControllerOperation operation;

@end

@implementation CustomPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    _popManager = [AlphaPanManager managerWithDirection:AlphaPanManagerGestureDirectionRight type:AlphaPanManagerTypePop];
    [_popManager addPanGestureToVC:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    _operation = operation;
    return [CustomNavAnimation animationWithType:operation == UINavigationControllerOperationPush ? CustomNavAnimationTypePush : CustomNavAnimationTypePop];
    
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if (_operation == UINavigationControllerOperationPop) {
        return _popManager.interactiving ? _popManager : nil;
    } else {
        return nil;
    }
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
