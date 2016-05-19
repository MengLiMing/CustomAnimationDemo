//
//  SpreadAnimation.m
//  CustomAnimationDemo
//
//  Created by my on 16/4/2.
//  Copyright © 2016年 base. All rights reserved.
//

#import "SpreadAnimation.h"
#import "SpreadViewController.h"
#import "BaseTabBarController.h"

@implementation SpreadAnimation

+ (instancetype)animationWithType:(SpreadAnimationType)type {
    return [[self alloc] initWithAnimationType:type];
}


- (instancetype)initWithAnimationType:(SpreadAnimationType)type {
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
        case SpreadAnimationTypePresent:
        {
            [self presentWith:transitionContext];
        }
            break;
        case SpreadAnimationTypeDismiss:
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
    //
    BaseTabBarController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UINavigationController *vc =fromVC.viewControllers.firstObject;
    SpreadViewController *temp = vc.viewControllers.lastObject;
    //获取容器
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    
    
    //画两个圆路径
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithOvalInRect:temp.buttonFrame];
    //通过如下方法计算获取在x和y方向按钮距离边缘的最大值，然后利用勾股定理即可算出最大半径
    CGFloat x = MAX(temp.buttonFrame.origin.x, containerView.frame.size.width - temp.buttonFrame.origin.x);
    CGFloat y = MAX(temp.buttonFrame.origin.y, containerView.frame.size.height - temp.buttonFrame.origin.y);
    //计算半径
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    
    //以按钮中心为圆心，按钮中心岛屏幕边缘的最大距离为半径,得到转场后path
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    
    
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    //设置layer的path保证动画后layer不会回弹
    maskLayer.path = endCycle.CGPath;
    
    //将maskLayer作为toVC.view的遮盖
    toVC.view.layer.mask = maskLayer;
    
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    
    //动画施加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(endCycle.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    
    //设置淡入淡出
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

//dismiss
- (void)dismissWith:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    BaseTabBarController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UINavigationController *vc =toVC.viewControllers.firstObject;

    SpreadViewController *temp = vc.viewControllers.lastObject;
    
    
    UIView *containerView = [transitionContext containerView];
    CGFloat radius = sqrtf(containerView.frame.size.height * containerView.frame.size.height + containerView.frame.size.width * containerView.frame.size.width) / 2;
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:temp.buttonFrame];
    
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    fromVC.view.layer.mask = maskLayer;
    
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    switch (_type) {
        case SpreadAnimationTypePresent:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
        }
            break;
        case SpreadAnimationTypeDismiss:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            }
        }
            break;
    }
}

@end
