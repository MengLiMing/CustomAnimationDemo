//
//  UINavigationController+Category.h
//  BaseProject
//
//  Created by my on 16/3/24.
//  Copyright © 2016年 base. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Category)

- (void)ml_setBackgroundColor:(UIColor *)backgroundColor;
- (void)ml_setLeftRightAlpha:(CGFloat)alpha;
- (void)ml_setTitleAlpha:(CGFloat)alpha;

- (void)ml_setTranslationY:(CGFloat)translationY;
- (void)ml_reset;

@end
