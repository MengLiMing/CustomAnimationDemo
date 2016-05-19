//
//  PresentDismissTransition.m
//  CustomAnimationDemo
//
//  Created by my on 16/3/30.
//  Copyright © 2016年 base. All rights reserved.
//

#import "PresentDismissTransition.h"
#import "UIView+FrameChange.h"

@interface PresentDismissTransition ()

@property (nonatomic, assign) PresentDimissTransitonType type;
@property (nonatomic, assign) PresentDimissAnimationType name;

@end

@implementation PresentDismissTransition


+ (instancetype)transitionWithTransitionType:(PresentDimissTransitonType)type animationName:(PresentDimissAnimationType)name{
    return [[self alloc] initWithTransitionType:type animationName:name];
}

- (instancetype)initWithTransitionType:(PresentDimissTransitonType)type animationName:(PresentDimissAnimationType)name{
    self = [super init];
    if (self) {
        _type = type;
        _name = name;
    }
    return self;
}



- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //为了将两种动画的逻辑分开，分开书写逻辑
    switch (_type) {
        case PresentDimissTransitonPresent:
        {
            [self presentAnimation:transitionContext];
        }
            break;
        case PresentDimissTransitonDismiss:
        {
            [self dismissAnimation:transitionContext];
        }
            break;
        default:
            break;
    }
}

//实现present动画逻辑代码
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    switch (_name) {
        case PresentDimissAnimationType2D:
        {
            [self present2D:transitionContext];
        }
            break;
        case PresentDimissAnimationType3D:
        {
            [self present3D:transitionContext];
        }
            break;
        default:
            break;
    }
}
- (void)present3D:(id<UIViewControllerContextTransitioning>)transitionContext {
    //通过viewControllerForKey取出转场前后的两个控制器
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView* containerView = [transitionContext containerView];
    toVC.view.frame = CGRectMake(0, containerView.height, containerView.width, 400);
    
    [containerView insertSubview:toVC.view aboveSubview:fromVC.view];
    
    
    //三维变化
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-1000;
    t1 = CATransform3DRotate(t1, 15.0f * M_PI/180.0f, 1, 0, 0);

    //x,y方向各缩放比例为.95
    t1 = CATransform3DScale(t1, .95, .95, 1);
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = 1.0/-1000;
    
    //沿Y方向向上移动
    t2 = CATransform3DTranslate(t2, 0, -fromVC.view.frame.size.height*0.08, 0);
    //在x y 方向各缩放比例为.8
    t2 = CATransform3DScale(t2, .8, .8, 1);
    
    //UIView关键帧过渡动画，总时间1.0
    [UIView animateKeyframesWithDuration:1.0
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
                                  //开始时间1.0 持续时间1.0*0.4
                                  [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.4 animations:^{
                                     //执行t1动画，缩放并旋转角度
                                      fromVC.view.layer.transform = t1;
                                      //
                                      fromVC.view.alpha = .6;
                                  }];
                                  //开始时间：1.0*0.1 持续时间：1.0*0.5
                                  [UIView addKeyframeWithRelativeStartTime:0.1f relativeDuration:0.5f animations:^{
                                      //执行t2动画 向上平移和缩放
                                      fromVC.view.layer.transform = t2;
                                  }];
                                  
                                  //开始时间：1.0*0.0 持续时间：1.0*1.0
                                  [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:1.0f animations:^{
                                      //toView向上滑入
                                      toVC.view.transform = CGAffineTransformMakeTranslation(0, -400);
                                  }];
                              }
                              completion:^(BOOL finished) {
                                  [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                              }];
}

- (void)present2D:(id<UIViewControllerContextTransitioning>)transitionContext {
    //通过viewControllerForKey取出转场前后的两个控制器
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //snapshotViewAfterScreenUpdates可以对某个视图截图，我们采用对这个截图做动画代替直接对vc1做动画，因为在手势过渡中直接使用vc1动画会和手势有冲突，如果不需要实现手势的话，就可以不是用截图视图了，大家可以自行尝试一下
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    
    //因为对截图做动画，fromVC可以隐藏
    fromVC.view.hidden = YES;
    
    //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理者所有做转场动画的视图
    UIView *containerView = [transitionContext containerView];
    //将截图和toVC的view都加入到containerView中
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    
    //设置toVC的frame，因为这里toVC prsent出来不是全屏.且初始的时候在底部，如果不设置frame的话默认就是整个屏幕咯，这里containerView的frame就是整个屏幕
    toVC.view.frame = CGRectMake(0, containerView.height, containerView.width, 400);
    //开始动画，使用产生图案黄效果的动画API
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:.6
          initialSpringVelocity:0
                        options:0
                     animations:^{
                         //首先让toVC向上移动
                         toVC.view.transform = CGAffineTransformMakeTranslation(0, -400);
                         //让截图视图缩小
                         tempView.transform = CGAffineTransformMakeScale(0.85, 0.85);
                     } completion:^(BOOL finished) {
                         //使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不是用手势的话直接传YES也是可以的，我们必须标记转场的状态，系统才知道处理转场后的操作，否则认为你一直还在执行转场，会出现无法交互的情况，切记
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         
                         //转场失败后的处理
                         if ([transitionContext transitionWasCancelled]) {
                             //失败后，将fromVC显示出来
                             fromVC.view.hidden = NO;
                             //移除截图视图
                             [tempView removeFromSuperview];
                         }
                     }];

}



//实现dismiss动画逻辑代码
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_name) {
        case PresentDimissAnimationType2D:
        {
            [self dismiss2D:transitionContext];
        }
            break;
        case PresentDimissAnimationType3D:
        {
            [self dismiss3D:transitionContext];
        }
            break;
        default:
            break;
    }
}
- (void)dismiss3D:(id<UIViewControllerContextTransitioning>)transitionContext {
    //fromVC与toVC根据执行的操作改变
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    

    
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-1000;
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    t1 = CATransform3DRotate(t1, 15.0f * M_PI/180.0f, 1, 0, 0);
    
    
    //关键帧过渡动画
    [UIView animateKeyframesWithDuration:1.0 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:1.0f animations:^{
            //滑出屏幕
            fromVC.view.transform = CGAffineTransformMakeTranslation(0, 400);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.35f relativeDuration:0.35f animations:^{
            //执行t1,沿着x,y放大，沿x旋转
            toVC.view.layer.transform = t1;
            //透明度变为1.0
            toVC.view.alpha = 1.0;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.75f relativeDuration:0.25f animations:^{
            //还原3D状态
            toVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

            toVC.view.layer.transform = CATransform3DIdentity;
        }];
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
- (void)dismiss2D:(id<UIViewControllerContextTransitioning>)transitionContext {
    //fromVC与toVC根据执行的操作改变
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //参照present的动画逻辑。present成功后，containerView的最后一个子视图就是截图视图，我们将其取出准备动画
    UIView *containerView = [transitionContext containerView];
    NSArray *subviewsArray = containerView.subviews;
    UIView *tempView = subviewsArray[MIN(subviewsArray.count, MAX(0, subviewsArray.count - 2))];
    
    //动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //因为present的时候都是使用的transform，这里的动画只需要将transform恢复就可以了
        fromVC.view.transform = CGAffineTransformIdentity;
        tempView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
        //转场成功后的处理
        if (![transitionContext transitionWasCancelled]) {
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
        
    }];
}
@end
