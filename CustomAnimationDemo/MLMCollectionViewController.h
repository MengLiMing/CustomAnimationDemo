//
//  MLMCollectionViewController.h
//  CustomAnimationDemo
//
//  Created by my on 16/3/31.
//  Copyright © 2016年 base. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLMCollectionViewController : UICollectionViewController

/**
 *  记录当前点击的indexPath
 */
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end
