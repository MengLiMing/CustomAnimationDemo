//
//  MLMInteractiveTransition.m
//  CustomAnimationDemo
//
//  Created by my on 16/3/30.
//  Copyright © 2016年 base. All rights reserved.
//

#import "MLMInteractiveTransition.h"

@interface MLMInteractiveTransition ()

@property (nonatomic, weak) UIViewController *vc;

@property (nonatomic, assign) MLMInteractiveTranstionType type;
@property (nonatomic, assign) MLMInteractiveTranstionGestureDirection direction;
@end

@implementation MLMInteractiveTransition

+ (instancetype)interactiveTransitionWithTransitionType:(MLMInteractiveTranstionType)type GestureDirection:(MLMInteractiveTranstionGestureDirection)direction {
    return [[self alloc] initWithTransitionType:type GestureDirection:direction];
}

- (instancetype)initWithTransitionType:(MLMInteractiveTranstionType)type GestureDirection:(MLMInteractiveTranstionGestureDirection)direction {
    self = [super init];
    if (self) {
        _direction = direction;
        _type = type;
    }
    return self;
}
- (void)addPanGestureForViewController:(UIViewController *)viewController{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    self.vc = viewController;
    [viewController.view addGestureRecognizer:pan];
}

- (void)handleGesture:(UIPanGestureRecognizer *)panGesture {
    //present是根据panGesture的移动距离获取的
    CGFloat persent = 0;
    //手势百分比
    NSLog(@"%@",NSStringFromCGPoint([panGesture translationInView:panGesture.view]));
    switch (_direction) {
        case MLMInteractiveTranstionGestureDirectionLeft:
        {
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case MLMInteractiveTranstionGestureDirectionRight:
        {
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case MLMInteractiveTranstionGestureDirectionUp:
        {
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.height;
        }
            break;
        case MLMInteractiveTranstionGestureDirectionDown:
        {
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.height;
        }
            break;
        default:
            break;
    }
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            //手势开始，标记手势状态，并开始相应的事件
            self.interation = YES;
            [self startGesture];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            //手势过程中，通过updateInteractiveTransition设置动画过程的百分比
            [self updateInteractiveTransition:persent];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            self.interation = NO;
            //判断persent是否过半，过则finishInteractiveTransition完成转场操作，否则取消转场操作
            if (persent < 0.5 || panGesture.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
        }
            break;
        default:
            break;
    }
    
}

- (void)startGesture {
    switch (_type) {
        case MLMInteractiveTranstionTypePresent:
        {
            if (self.presentAction) {
                self.presentAction();
            }
        }
            break;
        case MLMInteractiveTranstionTypeDismiss:
        {
            [_vc dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case MLMInteractiveTranstionTypePush:
        {
            if (self.pushAction) {
                self.pushAction();
            }
        }
            break;
        case MLMInteractiveTranstionTypePop:
        {
            [_vc.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        default:
            break;
    }
}
@end
