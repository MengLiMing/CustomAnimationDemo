//
//  SpreadAnimation.h
//  CustomAnimationDemo
//
//  Created by my on 16/4/2.
//  Copyright © 2016年 base. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,SpreadAnimationType) {
    SpreadAnimationTypePresent = 0,
    SpreadAnimationTypeDismiss
};
@interface SpreadAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) SpreadAnimationType type;

+ (instancetype)animationWithType:(SpreadAnimationType)type;
- (instancetype)initWithAnimationType:(SpreadAnimationType)type;

@end
