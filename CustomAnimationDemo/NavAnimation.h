//
//  NavAnimation.h
//  CustomAnimationDemo
//
//  Created by my on 16/3/31.
//  Copyright © 2016年 base. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  动画过渡代理管理的是push还是pop
 */
typedef NS_ENUM(NSUInteger, NavAnimationType) {
    NavAnimationPush = 0,
    NavAnimationPop
};
@interface NavAnimation : NSObject <UIViewControllerAnimatedTransitioning>

/**
 *  初始化动画过渡代理
 */
+ (instancetype)transitionWithType:(NavAnimationType)type;
- (instancetype)initWithTransitionType:(NavAnimationType)type;

@end
