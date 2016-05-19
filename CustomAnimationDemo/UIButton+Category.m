//
//  UIButton+block.m
//  TangXianManual
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 Han. All rights reserved.
//

#import "UIButton+Category.h"
#import <objc/runtime.h>

static char overviewKey;//点击事件

static char timerKey;//定时器
static char waitkey;//定时器设定时间
static char timeOverkey;//定时器结束事件

@implementation UIButton (Category)

#pragma mark - button点击事件
- (void)handleContentEvent:(UIControlEvents)event withBlock:(ActionBlock)action {
    objc_setAssociatedObject(self, &overviewKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}


- (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block();
    }
}

#pragma mark - 设置图片在右，文字在左
- (void)setRightImage {
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.frame.size.width, 0, self.imageView.frame.size.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width, 0, -self.titleLabel.bounds.size.width)];
}

#pragma mark - 倒计时
- (void)waitAuthCode:(NSInteger)wait completion:(TimeOverBlock)finish {
    //倒计时
    self.enabled = false;
    self.backgroundColor = RGB16(COLOR_BG_GRAY);
    [self setTitleColor:RGB16(COLOR_FONT_LIGHTGRAY) forState:UIControlStateNormal];
    [self setTitle:[NSString stringWithFormat:@"重新发送(%ld)",(long)wait] forState:UIControlStateDisabled];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(authTick) userInfo:nil repeats:YES];
    
    //添加属性
    [self setTimer:timer];
    [self setWait:wait];
    [self setTimeOver:finish];

}
- (void)authTick
{
    NSInteger wait = [self getWait];
    wait--;
    NSTimer *timer = [self getTimer];
    if(wait == 0)
    {
        [timer invalidate];
        timer = nil;
        self.enabled = true;
        self.backgroundColor = RGB16(COLOR_BG_RED);
        [self setTitleColor:RGB16(COLOR_FONT_WHITE) forState:UIControlStateNormal];
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        TimeOverBlock block = [self getTimeOver];
        if (block) {
            block();
        }
        //关闭定时器
        timer = nil;
        [timer invalidate];
        [self setTimer:timer];
    }
    else
    {
        [self setTitle:[NSString stringWithFormat:@"重新发送(%ld)",(long)wait] forState:UIControlStateDisabled];
        [self setWait:wait];
    }
}
//定时器
- (void)setTimer:(NSTimer *)timer {
    objc_setAssociatedObject(self, &timerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimer *)getTimer {
    return objc_getAssociatedObject(self, &timerKey);
}
//倒计时时间
- (void)setWait:(NSInteger)wait {
    objc_setAssociatedObject(self, &waitkey, [NSNumber numberWithInteger:wait], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSInteger)getWait {
    return [objc_getAssociatedObject(self, &waitkey) integerValue];
}
//定时器结束
- (void)setTimeOver:(TimeOverBlock)finish {
    objc_setAssociatedObject(self, &timeOverkey, finish, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TimeOverBlock)getTimeOver {
    return objc_getAssociatedObject(self, &timeOverkey);
}

#pragma mark - button工厂方法
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              Title:(NSString *)title
                       normaleImage:(UIImage *)normalImage
                        selectImage:(UIImage *)selectImage
                    backGroundColor:(UIColor *)backGroudColor
                         titleColor:(UIColor *)titleColor
                          titleFont:(UIFont *)font
                         buttonType:(UIButtonType)type {
    UIButton *button = [UIButton buttonWithType:type];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:selectImage forState:UIControlStateSelected];
    button.backgroundColor = backGroudColor;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}

@end
