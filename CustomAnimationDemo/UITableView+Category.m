//
//  UITableView+cellIndex.m
//  WeiBo
//
//  Created by qingyun on 15/6/26.
//  Copyright (c) 2015年 qingyun.con. All rights reserved.
//

#import "UITableView+Category.h"

@implementation UITableView (Category)

//group 类型tableview，得到当前indexpath的行数
-(NSInteger)cellIndexForIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger cellIndex = 0;
    for (NSInteger section = 0; section < indexPath.section; section++) {
        cellIndex += [self numberOfRowsInSection:section];
    }
    
    cellIndex += indexPath.row;
    
    return cellIndex;
}

@end
