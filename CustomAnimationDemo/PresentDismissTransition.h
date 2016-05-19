//
//  PresentDismissTransition.h
//  CustomAnimationDemo
//
//  Created by my on 16/3/30.
//  Copyright © 2016年 base. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,PresentDimissAnimationType) {
    PresentDimissAnimationType2D = 0,
    PresentDimissAnimationType3D
};

typedef NS_ENUM(NSUInteger, PresentDimissTransitonType) {
    PresentDimissTransitonPresent = 0,//管理present动画
    PresentDimissTransitonDismiss//管理dismiss动画
};

@interface PresentDismissTransition : NSObject <UIViewControllerAnimatedTransitioning>

//根据定义的枚举初始化的两个方法
+ (instancetype)transitionWithTransitionType:(PresentDimissTransitonType)type animationName:(PresentDimissAnimationType)name;
- (instancetype)initWithTransitionType:(PresentDimissTransitonType)type animationName:(PresentDimissAnimationType)name;

@end
