//
//  MLMInteractiveTransition.h
//  CustomAnimationDemo
//
//  Created by my on 16/3/30.
//  Copyright © 2016年 base. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureAction)();

/**手势方向*/
typedef NS_ENUM(NSUInteger, MLMInteractiveTranstionGestureDirection) {
    MLMInteractiveTranstionGestureDirectionLeft = 0,
    MLMInteractiveTranstionGestureDirectionRight,
    MLMInteractiveTranstionGestureDirectionUp,
    MLMInteractiveTranstionGestureDirectionDown
};

/**手势控制哪种转场*/
typedef NS_ENUM(NSUInteger, MLMInteractiveTranstionType) {
    MLMInteractiveTranstionTypePresent = 0,
    MLMInteractiveTranstionTypeDismiss,
    MLMInteractiveTranstionTypePush,
    MLMInteractiveTranstionTypePop
};

@interface MLMInteractiveTransition : UIPercentDrivenInteractiveTransition

/**记录是否开始手势，判断pop操作是手势触发还是返回键触发*/
@property (nonatomic, assign) BOOL interation;

/**促发手势present的时候的config，config中初始化并present需要弹出的控制器*/
@property (nonatomic, copy) GestureAction presentAction;
/**促发手势push的时候的config，config中初始化并push需要弹出的控制器*/
@property (nonatomic, copy) GestureAction pushAction;


//初始化方法
+ (instancetype)interactiveTransitionWithTransitionType:(MLMInteractiveTranstionType)type GestureDirection:(MLMInteractiveTranstionGestureDirection)direction;

- (instancetype)initWithTransitionType:(MLMInteractiveTranstionType)type GestureDirection:(MLMInteractiveTranstionGestureDirection)direction;

/** 给传入的控制器添加手势*/
- (void)addPanGestureForViewController:(UIViewController *)viewController;

@end
