//
//  PresentViewController.m
//  CustomAnimationDemo
//
//  Created by my on 16/3/31.
//  Copyright © 2016年 base. All rights reserved.
//

#import "PresentViewController.h"
#import "ModelViewController.h"
#import "AlphaAnimation.h"//动画管理
#import "AlphaPanManager.h"//手势管理

@interface PresentViewController () <ModelViewControllerDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) AlphaPanManager *presentManager;
@property (nonatomic, strong) AlphaPanManager *dismissManager;

@end

@implementation PresentViewController
- (void)dealloc {
    NSLog(@"销毁了");
}
- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 90, SCREEN_WIDTH, 40.0);
    [button setTitle:@"点我或者上滑出现" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    WEAK(weakSelf);
    _presentManager = [AlphaPanManager managerWithDirection:AlphaPanManagerGestureDirectionUp type:AlphaPanManagerTypePresent];
    _presentManager.presentAction = ^(){
        [weakSelf present];
    };
    [_presentManager addPanGestureToVC:self];
}

- (void)buttonClicked:(UIButton *)sender {
    [self present];
}

- (void)present {
    ModelViewController *vc = [[ModelViewController alloc] init];
    vc.delegate = self;
    vc.transitioningDelegate = self;
    /*设置为UIModalPresentationCustom的时候动画结束后。presentVC不会被移除，而不设置是会被移除，理论来说在动画结束后要将presentVC在添加到控制容器containerView中，但实际测试效果不明显(加入手势动画后，效果明显)
     * 设置为custom后，prensent之后观察图层，presentVC未被移除，但是dismiss之后，视图全部消失
     */
//    vc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
    
    
    _dismissManager = [AlphaPanManager managerWithDirection:AlphaPanManagerGestureDirectionDown type:AlphaPanManagerTypeDismiss];
    [_dismissManager addPanGestureToVC:vc];
}

#pragma mark - ModelViewControllerDelegate
- (void)dismissWhenClick:(UIViewController *)viewcontroller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [AlphaAnimation alphaAnimationWith:AlphaAnimationTypePresent];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [AlphaAnimation alphaAnimationWith:AlphaAnimationTypeDismiss];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return _presentManager.interactiving?_presentManager:nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return _dismissManager.interactiving?_dismissManager:nil;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
