//
//  PagePushAnimation.m
//  CustomAnimationDemo
//
//  Created by my on 16/3/31.
//  Copyright © 2016年 base. All rights reserved.
//

#import "PagePushAnimation.h"

@interface PagePushAnimation ()

@property (nonatomic, assign) PagePushAnimationType type;
@end

@implementation PagePushAnimation

+ (instancetype)animationWith:(PagePushAnimationType)type {
    return [[self alloc] initWithAnimation:type];
}

- (instancetype)initWithAnimation:(PagePushAnimationType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case PagePushAnimationTypePush:
        {
            [self pushWith:transitionContext];
        }
            break;
        case PagePushAnimationTypePop:
        {
            [self popWith:transitionContext];
        }
            break;
        default:
            break;
    }
}

//push动画
- (void)pushWith:(id<UIViewControllerContextTransitioning>)transitionContext {
    //1.获取fromVC和toVC
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //对fromVC的view的截图做动画，参数设置能NO表示立即生成屏幕快照
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    
    //移动并改变锚点
    tempView.frame = CGRectMake(-fromVC.view.frame.size.width/2, 0, fromVC.view.frame.size.width, fromVC.view.frame.size.height);
    [tempView.layer setAnchorPoint:CGPointMake(0, 0.5)];
    

    
    //获取动画管理
    UIView *containerView = [transitionContext containerView];
    
//    struct CATransform3D
//    {
//        CGFloat   m11（x缩放）,  m12（y切变）,  m13（旋转）, m14（）;
//        
//        CGFloat   m21（x切变）,  m22（y缩放）,  m23（）,    m24（）;
//        
//        CGFloat   m31（旋转）,   m32（ ）,     m33（）,     m34（透视效果，要操作的这个对象要有旋转的角度，否则没有效果。正直/负值都有意义）;
//        
//        CGFloat   m41（x平移）,  m42（y平移）,  m43（z平移）,m44（）;
//    };
    CATransform3D transfrom3d = CATransform3DIdentity;
    transfrom3d.m34 = -0.002;
    containerView.layer.sublayerTransform = transfrom3d;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];

    //设置动画开始时状态
    fromVC.view.hidden = YES;
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if (![transitionContext transitionWasCancelled]) {
            tempView.hidden = YES;
        } else {
            [tempView removeFromSuperview];
            fromVC.view.hidden = NO;
        }
    }];
}


//pop动画
- (void)popWith:(id<UIViewControllerContextTransitioning>)transitionContext {
    //1.获取fromVC和toVC
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //获取动画管理
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;
    
    [containerView addSubview:toVC.view];
    //设置动画开始时状态
    tempView.hidden = NO;
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if (![transitionContext transitionWasCancelled]) {
            [tempView removeFromSuperview];
            toVC.view.hidden = NO;
        } else {
            tempView.hidden = YES;
        }
    }];
}

@end
