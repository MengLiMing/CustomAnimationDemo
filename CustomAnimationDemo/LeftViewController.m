//
//  LeftViewController.m
//  CustomAnimationDemo
//
//  Created by my on 16/4/4.
//  Copyright © 2016年 base. All rights reserved.
//

#import "LeftViewController.h"
#import "PureLayout.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
    
    
    UILabel *label = [UILabel newAutoLayoutView];
    [self.view addSubview:label];
    
    [label autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [label autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [label autoSetDimension:ALDimensionHeight toSize:40];
    [label autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
    
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:30];
    label.text = @"左侧视图";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
