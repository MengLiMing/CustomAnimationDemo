//
//  BaseTabBarController.m
//  ShopManager
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 Xydawn. All rights reserved.
//

#import "BaseTabBarController.h"
#import "ListViewController.h"

#import "UIImage+Category.h"


#import "CebianAnimation.h"
#import "LeftViewController.h"
#import "AlphaPanManager.h"

@interface BaseTabBarController ()<UITabBarControllerDelegate,UIAlertViewDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) AlphaPanManager *presentManager;
@property (nonatomic, strong) AlphaPanManager *dismissManager;
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    [self addVC];
    [self initTabbar];
    
    // Do any additional setup after loading the view.
    WEAK(weakSelf);
    _presentManager = [AlphaPanManager managerWithDirection:AlphaPanManagerGestureDirectionRight type:AlphaPanManagerTypePresent];
    _presentManager.presentAction = ^(){
        [weakSelf present];
    };
    [_presentManager addPanGestureToVC:self];

}



- (void)present {
    LeftViewController *vc = [LeftViewController new];
    vc.transitioningDelegate = self;
    
    _dismissManager = [AlphaPanManager managerWithDirection:AlphaPanManagerGestureDirectionLeft type:AlphaPanManagerTypeDismiss];
    [_dismissManager addPanGestureToVC:vc];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)addVC {
    ListViewController *vc1 = [[ListViewController alloc]init];
    [self setupChildViewController:vc1 title:@"1" imageName:@"" selectedImageName:@""];
    
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.view.backgroundColor = [UIColor whiteColor];
    [self setupChildViewController:vc2 title:@"2" imageName:@"" selectedImageName:@""];
    
    UIViewController *vc3 = [[UIViewController alloc]init];
    vc3.view.backgroundColor = [UIColor whiteColor];
    [self setupChildViewController:vc3 title:@"3" imageName:@"" selectedImageName:@""];
    
    UIViewController *vc4 = [[UIViewController alloc]init];
    vc4.view.backgroundColor = [UIColor whiteColor];
    [self setupChildViewController:vc4 title:@"4" imageName:@"" selectedImageName:@""];
    
    UIViewController *vc5 = [[UIViewController alloc]init];
    vc5.view.backgroundColor = [UIColor whiteColor];
    [self setupChildViewController:vc5 title:@"5" imageName:@"" selectedImageName:@""];
}

- (void)initTabbar {
    //设置未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB16(COLOR_FONT_BLACK), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    //设置选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB16(COLOR_FONT_RED), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    //设置tabbar背景颜色
    [[UITabBar appearance] setBackgroundColor:[UIColor redColor]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:RGB16(COLOR_BG_ORANGE) andSize:self.tabBar.frame.size]];
    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:RGB16(COLOR_BG_ORANGE) andSize:CGSizeMake(SCREEN_WIDTH, 1)]];
}

- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
 
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:nav];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (NO) {
        return NO;
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 代理
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [CebianAnimation animationWithType:CebianAnimationTypePresent name:CebianAnimationNameQQ];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [CebianAnimation animationWithType:CebianAnimationTypeDismiss name:CebianAnimationNameQQ];

}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return _presentManager.interactiving ? _presentManager : nil;
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
