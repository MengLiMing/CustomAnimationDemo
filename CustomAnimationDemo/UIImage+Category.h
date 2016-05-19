//
//  UIImage+Category.h
//  live
//
//  Created by kenneth on 15-7-9.
//  Copyright (c) 2015年 kenneth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
- (UIImage*)getSubImage:(CGRect)rect;
@end
