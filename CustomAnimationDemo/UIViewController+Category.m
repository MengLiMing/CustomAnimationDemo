//
//  UIViewController+Category.m
//  BaseProject
//
//  Created by my on 16/3/24.
//  Copyright © 2016年 base. All rights reserved.
//

#import "UIViewController+Category.h"
#import "UINavigationBar+Category.h"

@implementation UIViewController (Category)
- (void)lm_SetNavBarWith:(UIScrollView *)scrollView {
    UIColor * color = KNAVBARCOLOR;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < -20 ) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        if (offsetY > 50) {
            CGFloat alpha = MIN(1, 1 - ((50 + 64 - offsetY) / 64));
            [self.navigationController.navigationBar ml_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
            
            [self.navigationController.navigationBar ml_setLeftRightAlpha:alpha];
            [self.navigationController.navigationBar ml_setTitleAlpha:alpha];
        } else {
            [self.navigationController.navigationBar ml_setBackgroundColor:[color colorWithAlphaComponent:0]];

            [self.navigationController.navigationBar ml_setLeftRightAlpha:0];
            
            [self.navigationController.navigationBar ml_setTitleAlpha:0];
        }
    }
}

//设置navigationBar透明
- (void)setUpNavigationBar
{

    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
//    //去除背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
}
@end
