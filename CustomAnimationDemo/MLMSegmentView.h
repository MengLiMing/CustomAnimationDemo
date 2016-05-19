//
//  MLMSegmentView.h
//  BaseProject
//
//  Created by my on 16/3/23.
//  Copyright © 2016年 base. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLMSegmentView : UIScrollView

@property (nonatomic, copy) void (^chooseTap)(NSInteger tag);

@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSArray *headArray;

- (instancetype)initWithFrame:(CGRect)frame withSource:(NSArray *)arr;

@end
