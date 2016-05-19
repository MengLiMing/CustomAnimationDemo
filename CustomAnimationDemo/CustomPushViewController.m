//
//  CustomPushViewController.m
//  CustomAnimationDemo
//
//  Created by my on 16/4/6.
//  Copyright © 2016年 base. All rights reserved.
//

#import "CustomPushViewController.h"
#import "CustomPopViewController.h"

@interface CustomPushViewController ()

@end

@implementation CustomPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushAction:(UIButton *)sender {
    CustomPopViewController *vc = [[CustomPopViewController alloc] init];
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
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
