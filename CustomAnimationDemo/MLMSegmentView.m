//
//  MLMSegmentView.m
//  BaseProject
//
//  Created by my on 16/3/23.
//  Copyright © 2016年 base. All rights reserved.
//

#import "MLMSegmentView.h"
#import "NSString+Category.h"

#define SELECT_COLOR [UIColor redColor]
#define DE_SELECT_COLOR [UIColor lightGrayColor]
//字体
#define K_Button_Font [UIFont systemFontOfSize:14]
//每个button中字到边缘的距离
#define K_Sep 15
//下标线高
#define LINE_H 2

@interface MLMSegmentView ()
{
    CGFloat sep;
    
}
@property (nonatomic, strong) UIView *lineView;

@end

@implementation MLMSegmentView

- (instancetype)initWithFrame:(CGRect)frame withSource:(NSArray *)arr{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.alwaysBounceVertical = NO;
        self.bounces = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.headArray = arr;
    }
    return self;
}

- (void)setHeadArray:(NSArray *)headArray {
    _headArray = headArray;
    [self setContentSize];
}

//通过数据源更改显示
- (void)setContentSize {
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
    self.lineView = nil;
    //数组中的字符串连接
    NSString *arrStr = [self.headArray componentsJoinedByString:@""];
    //根据字符串的长度 设置self的contentSize
    CGFloat arrStr_W = [self stringWidthWith:arrStr];
    

    //设置scroll的contentSize
    if (arrStr_W + K_Sep * self.headArray.count * 2 > self.frame.size.width) {
        self.contentSize = CGSizeMake(arrStr_W + K_Sep * self.headArray.count * 2, self.frame.size.height);
        sep = K_Sep;
        [self createViewWith:0];
    } else {
        //判断均分宽度
        NSArray *sortArr = [self.headArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSString *str1 = obj1;
            NSString *str2 = obj2;
            return str1.length > str2.length;
        }];
        //以最长字符串的宽度均分
        if ((self.frame.size.width - [self stringWidthWith:sortArr.lastObject] * self.headArray.count) > K_Sep * self.headArray.count * 2) {
            self.contentSize = self.frame.size;
            sep = (self.frame.size.width - [self stringWidthWith:sortArr.lastObject] * self.headArray.count)/self.headArray.count/2;
        } else {
            self.contentSize = CGSizeMake([self stringWidthWith:sortArr.lastObject] * self.headArray.count + K_Sep * self.headArray.count * 2, self.frame.size.height);
            sep = K_Sep;
        }
        
        [self createViewWith:[self stringWidthWith:sortArr.lastObject]];
    }
    self.selectIndex = 0;
}

//布局
- (void)createViewWith:(CGFloat)w {

    //起点
    CGFloat button_x = 0;
    for (NSInteger i = 0; i < self.headArray.count; i ++ ) {
        CGFloat kButtonW =( w == 0 ? [self stringWidthWith:self.headArray[i]]: w )+ 2 * sep;
        CGFloat kButtonH = self.frame.size.height;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(button_x, 0, kButtonW, kButtonH)];
        [button setTitle:self.headArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 999 + i;
        [self addSubview:button];
        
        button_x = button.frame.size.width + button.frame.origin.x;
        //添加分割线
        if (i != self.headArray.count) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(button_x, 4, 1, self.frame.size.height - 8)];
            line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self addSubview:line];
        }
    }
}


//工厂方法
- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    if (self.chooseTap) {
        self.chooseTap(self.selectIndex);
    }
    [self changeTitleColor];
    [self changgeOffSet];
    if (self.lineView) {
        [self changeLineView];
    }
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - LINE_H, 0, LINE_H)];
        _lineView.backgroundColor = SELECT_COLOR;
        [self addSubview:_lineView];
    }
    return _lineView;
}


//根据字符串返回高度
- (CGFloat)stringWidthWith:(NSString *)str {
    return [str stringSizeWithFont:K_Button_Font Size:CGSizeMake(MAXFLOAT, self.frame.size.height)].width;
}


#pragma makr - 点击事件
- (void)tapButton:(UIButton *)sender {
    self.selectIndex = sender.tag - 999;
}
//改变button字体颜色
- (void)changeTitleColor {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *but = (UIButton *)view;
            if ((but.tag - 999) == self.selectIndex) {
                [but setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
                [but.titleLabel setFont:[UIFont systemFontOfSize:16]];
            } else {
                [but setTitleColor:DE_SELECT_COLOR forState:UIControlStateNormal];
                [but.titleLabel setFont:[UIFont systemFontOfSize:14]];

            }
        }
    }
}

//改变line的位置和宽度
- (void)changeLineView {
    UIButton *button = [self viewWithTag:999 + self.selectIndex];
    self.lineView.frame = CGRectMake(button.frame.origin.x, self.frame.size.height - LINE_H, button.frame.size.width, LINE_H);
}


//改变scrollView偏移量
- (void)changgeOffSet {
    UIButton *button = [self viewWithTag:999 + self.selectIndex];
    //判断button的中心y与屏幕scroll宽度一半的关系,确定是否偏移
    CGFloat result = button.frame.origin.x + button.frame.size.width/2 - self.frame.size.width/2;
    CGFloat p_x = result < 0 ? 0 : (result < (self.contentSize.width - self.frame.size.width) ? result : self.contentSize.width - self.frame.size.width);
    
    [self setContentOffset:CGPointMake(p_x, 0) animated:YES];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
