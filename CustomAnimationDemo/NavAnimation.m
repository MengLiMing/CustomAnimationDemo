//
//  NavAnimation.m
//  CustomAnimationDemo
//
//  Created by my on 16/3/31.
//  Copyright © 2016年 base. All rights reserved.
//

#import "NavAnimation.h"

#import "MLMCollectionViewCell.h"
#import "MLMCollectionViewController.h"
#import "PushViewController.h"

@interface NavAnimation ()

/**
 *  动画过渡代理管理的是push还是pop
 */
@property (nonatomic, assign) NavAnimationType type;

@end

@implementation NavAnimation

+ (instancetype)transitionWithType:(NavAnimationType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(NavAnimationType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return .75f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case NavAnimationPush:
        {
            [self pushWith:transitionContext];
        }
            break;
        case NavAnimationPop:
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
    MLMCollectionViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    PushViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //拿到当前点击的cell的imageView
    MLMCollectionViewCell *cell = (MLMCollectionViewCell*)[fromVC.collectionView cellForItemAtIndexPath:fromVC.currentIndexPath];
    
    //动画控制器
    UIView *containerView = [transitionContext containerView];
    
    //snapshotViewAfterScreenUpdates 对cell的imageView截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
    UIView *tempView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];;
    
    //设置动画开始前各个空间的状态
    cell.imageView.hidden = YES;
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;
    
    //tempView添加到动画控制器中，因为动画效果为现在在前边，所以后添加
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    
    //动画开始
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:0.55
          initialSpringVelocity:1 / 0.55
                        options:0
                     animations:^{
                         tempView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
                         toVC.view.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         
                         if ([transitionContext transitionWasCancelled]) {
                             cell.imageView.hidden = NO;
                             [tempView removeFromSuperview];
                         } else {
                             tempView.hidden = YES;
                             toVC.imageView.hidden = NO;
                         }
                     }];
    
    
}

//pop动画
- (void)popWith:(id<UIViewControllerContextTransitioning>)transitionContext {
    PushViewController *fromVC= [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    MLMCollectionViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //拿到当前点击的cell的imageView
    MLMCollectionViewCell *cell = (MLMCollectionViewCell*)[toVC.collectionView cellForItemAtIndexPath:toVC.currentIndexPath];
    
    //拿到tempView
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;
    
    //设置动画开始时的状态
//    cell.imageView.hidden = YES;
    fromVC.imageView.hidden = YES;
    tempView.hidden = NO;
    
    [containerView insertSubview:toVC.view atIndex:0];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:0.55
          initialSpringVelocity:1 / 0.55
                        options:0
                     animations:^{
                         tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
                         fromVC.view.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         if ([transitionContext transitionWasCancelled]) {
                             tempView.hidden = YES;
                             fromVC.imageView.hidden = NO;
                         } else {
                             cell.imageView.hidden = NO;
                             [tempView removeFromSuperview];
                         }
                     }];
    
    
}
@end
