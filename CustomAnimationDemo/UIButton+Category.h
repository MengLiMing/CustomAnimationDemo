//
//  UIButton+block.h
//  TangXianManual
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ActionBlock)();
typedef void (^TimeOverBlock)();
@interface UIButton (Category)

- (void)handleContentEvent:(UIControlEvents)event withBlock:(ActionBlock)action;

//设置图片在右，文字在左
- (void)setRightImage;

//定时器
- (void)waitAuthCode:(NSInteger)duration completion:(TimeOverBlock)finish;

//button
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              Title:(NSString *)title
                       normaleImage:(UIImage *)normalImage
                        selectImage:(UIImage *)selectImage
                    backGroundColor:(UIColor *)backGroudColor
                         titleColor:(UIColor *)titleColor
                          titleFont:(UIFont *)font
                         buttonType:(UIButtonType)type;
@end
