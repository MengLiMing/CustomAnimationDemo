//
//  CebianAnimation.h
//  CustomAnimationDemo
//
//  Created by my on 16/4/4.
//  Copyright © 2016年 base. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,CebianAnimationName) {
    CebianAnimationNameZYB = 0,
    CebianAnimationNameQQ
};

typedef NS_ENUM(NSUInteger,CebianAnimationType) {
    CebianAnimationTypePresent = 0,
    CebianAnimationTypeDismiss
};
@interface CebianAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CebianAnimationName name;
@property (nonatomic, assign) CebianAnimationType type;

+ (instancetype)animationWithType:(CebianAnimationType)type name:(CebianAnimationName)name;
- (instancetype)initWithAnimationType:(CebianAnimationType)type name:(CebianAnimationName)name;

@end
