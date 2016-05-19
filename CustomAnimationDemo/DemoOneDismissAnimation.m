//
//  DemoOneDismissAnimation.m
//  CustomAnimationDemo
//
//  Created by my on 16/3/30.
//  Copyright © 2016年 base. All rights reserved.
//

#import "DemoOneDismissAnimation.h"

@implementation DemoOneDismissAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return .4f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //得到fromVC 和 toVC
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    /* 自定义动画实现
     * -(CGRect)initialFrameForViewController:(UIViewController *)vc;
     * 某个VC的初始位置，可以用来做动画的计算
     *
     * -(CGRect)finalFrameForViewController:(UIViewController *)vc;
     * 与上面的方法对应，得到切换结束时某个VC应在的frame
     */
    CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalFrame = CGRectOffset(initFrame, 0, screenBounds.size.height);
    
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
}
@end
