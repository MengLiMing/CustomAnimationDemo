//
//  AlphaAnimation.m
//  CustomAnimationDemo
//
//  Created by my on 16/3/31.
//  Copyright © 2016年 base. All rights reserved.
//

#import "AlphaAnimation.h"

@interface AlphaAnimation ()

@property (nonatomic, assign) AlphaAnimationType type;

@end
@implementation AlphaAnimation
+ (instancetype)alphaAnimationWith:(AlphaAnimationType)type {
    return [[self alloc] initWithAnimationWith:type];
}

- (instancetype)initWithAnimationWith:(AlphaAnimationType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return .5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case AlphaAnimationTypePresent:
        {
            [self presentWith:transitionContext];
        }
            break;
        case AlphaAnimationTypeDismiss:
        {
            [self dismissWith:transitionContext];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 动画逻辑
- (void)presentWith:(id<UIViewControllerContextTransitioning>)transitionContext {
    //获取fromVC 和 toVC
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //vc管理者
    UIView *container = [transitionContext containerView];
    [container addSubview:fromVC.view];
    [container addSubview:toVC.view];
    //设置toVC.view的frame
    toVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

    
//    //vc管理者
//    UIView *container = [transitionContext containerView];
//    
//    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
//    tempView.frame = fromVC.view.frame;
//    
//    [container addSubview:tempView];
//    [container addSubview:toVC.view];
//
//    //如果需要看到背景，则需要使用截屏API保存动画开始时的视图，因为动画结束时fromVC已经被移除
//    toVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, SCREEN_WIDTH/2);
//    toVC.view.center = fromVC.view.center;
    
    
    toVC.view.alpha = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)dismissWith:(id<UIViewControllerContextTransitioning>)transitionContext {
    //获取fromVC 和 toVC
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //vc管理者
    UIView *container = [transitionContext containerView];
    [container addSubview:toVC.view];
    [container sendSubviewToBack:toVC.view];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
