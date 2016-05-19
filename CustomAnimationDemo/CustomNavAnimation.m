//
//  CustomNavAnimation.m
//  CustomAnimationDemo
//
//  Created by my on 16/4/6.
//  Copyright © 2016年 base. All rights reserved.
//

#import "CustomNavAnimation.h"

@interface CustomNavAnimation ()

@property (nonatomic, assign) CustomNavAnimationType type;

@end

@implementation CustomNavAnimation

+ (instancetype)animationWithType:(CustomNavAnimationType)type {
    return [[self alloc] initWithAnimationType:type];
}

- (instancetype)initWithAnimationType:(CustomNavAnimationType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return .2f;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case CustomNavAnimationTypePush:
        {
            [self pushAnimationWith:transitionContext];
        }
            break;
        case CustomNavAnimationTypePop:
        {
            [self popAnimationWith:transitionContext];
        }
            break;
        default:
            break;
    }
}


//push
- (void)pushAnimationWith:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    toView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    
    fromView.alpha = .3f;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

//pop
- (void)popAnimationWith:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toView atIndex:0];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            toView.alpha = .3;
        } else {
            toView.alpha = 1.f;
        }
    }];
}

@end
