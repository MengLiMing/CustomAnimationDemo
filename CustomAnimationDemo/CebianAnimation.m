//
//  CebianAnimation.m
//  CustomAnimationDemo
//
//  Created by my on 16/4/4.
//  Copyright © 2016年 base. All rights reserved.
//

#import "CebianAnimation.h"
#import "UIView+FrameChange.h"


#import "BaseTabBarController.h"

@implementation CebianAnimation


+ (instancetype)animationWithType:(CebianAnimationType)type name:(CebianAnimationName)name{
    return [[self alloc] initWithAnimationType:type name:name];
}

- (instancetype)initWithAnimationType:(CebianAnimationType)type name:(CebianAnimationName)name{
    self = [super init];
    if (self) {
        _type = type;
        _name = name;
    }
    return self;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return .4f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case CebianAnimationTypePresent:
        {
            [self presentWith:transitionContext];
        }
            break;
        case CebianAnimationTypeDismiss:
        {
            [self dismissWith:transitionContext];
        }
            break;
        default:
            break;
    }
}

//present
- (void)presentWith:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_name) {
        case CebianAnimationNameZYB:
        {
            [self presentZYB:transitionContext];
        }
            break;
        case CebianAnimationNameQQ:
        {
            [self presentQQ:transitionContext];
        }
            break;
        default:
            break;
    }
    
}

- (void)presentZYB:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    UIView *tempFrom = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempFrom.frame = fromVC.view.frame;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempFrom];
    
    //设置动画开始前状态
    toVC.view.frame = CGRectMake(-SCREEN_WIDTH * 2/5, 0, SCREEN_WIDTH * 4/5, SCREEN_HEIGHT);
    toVC.view.transform = CGAffineTransformMakeScale(.3, .3);
    toVC.view.alpha = .1f;
    [toVC.view.layer setAnchorPoint:CGPointMake(0, 0.5)];
    
    fromVC.view.hidden = YES;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempFrom.transform = CGAffineTransformMakeScale(.85, .85);
        [tempFrom setX:SCREEN_WIDTH * 4/5];
        
        toVC.view.alpha = 1;
        toVC.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            [tempFrom removeFromSuperview];
            fromVC.view.hidden = NO;
        }
    }];

}


- (void)presentQQ:(id<UIViewControllerContextTransitioning>)transitionContext {
    BaseTabBarController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    UIView *tempFrom = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempFrom.frame = fromVC.view.frame;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempFrom];
    
    //设置动画开始前状态
    [toVC.view setX:-SCREEN_WIDTH * 1/5];
    fromVC.view.hidden = YES;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [tempFrom setX:SCREEN_WIDTH * 4/5];
        
        [toVC.view setX:0];

    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            [tempFrom removeFromSuperview];
            fromVC.view.hidden = NO;
        }
    }];
}

//dismiss
- (void)dismissWith:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_name) {
        case CebianAnimationNameZYB:
        {
            [self dismissZYB:transitionContext];
        }
            break;
        case CebianAnimationNameQQ:
        {
            [self dismissQQ:transitionContext];
        }
            break;
        default:
            break;
    }
    
}



- (void)dismissZYB:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    UIView *temp = containerView.subviews.lastObject;
    
    [containerView insertSubview:toVC.view atIndex:0];

    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        temp.transform = CGAffineTransformIdentity;
        temp.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

        
        fromVC.view.alpha = .1f;
        fromVC.view.transform = CGAffineTransformMakeScale(.3, .3);


    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //转场成功后的处理
        if (![transitionContext transitionWasCancelled]) {
            toVC.view.hidden = NO;
            [temp removeFromSuperview];
        }
        
    }];
}

- (void)dismissQQ:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    UIView *temp = containerView.subviews.lastObject;
    
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [temp setX:0];
        
        
        [fromVC.view setX:-SCREEN_WIDTH/5];
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //转场成功后的处理
        if (![transitionContext transitionWasCancelled]) {
            toVC.view.hidden = NO;
            [temp removeFromSuperview];
        }
        
    }];
}
@end
