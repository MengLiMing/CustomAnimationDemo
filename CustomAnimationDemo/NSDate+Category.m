//
//  NSDate+Category.m
//  JiuNianTang
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 FuTang. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

+ (NSString *)stringWithTimeInterval:(long long)time andDateFormatteString:(NSString *)string {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:string];
    return [df stringFromDate:date];
}

@end
