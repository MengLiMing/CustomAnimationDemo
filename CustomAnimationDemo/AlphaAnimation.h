//
//  AlphaAnimation.h
//  CustomAnimationDemo
//
//  Created by my on 16/3/31.
//  Copyright © 2016年 base. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,AlphaAnimationType) {
    AlphaAnimationTypePresent = 0,
    AlphaAnimationTypeDismiss
};

@interface AlphaAnimation : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)alphaAnimationWith:(AlphaAnimationType)type;
- (instancetype)initWithAnimationWith:(AlphaAnimationType)type;

@end
