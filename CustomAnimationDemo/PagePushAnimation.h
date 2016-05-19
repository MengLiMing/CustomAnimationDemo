//
//  PagePushAnimation.h
//  CustomAnimationDemo
//
//  Created by my on 16/3/31.
//  Copyright © 2016年 base. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,PagePushAnimationType) {
    PagePushAnimationTypePush,
    PagePushAnimationTypePop
};

@interface PagePushAnimation : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)animationWith:(PagePushAnimationType)type;
- (instancetype)initWithAnimation:(PagePushAnimationType)type;

@end
