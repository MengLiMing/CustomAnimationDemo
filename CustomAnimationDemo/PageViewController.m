//
//  PageViewController.m
//  CustomAnimationDemo
//
//  Created by my on 16/3/31.
//  Copyright © 2016年 base. All rights reserved.
//

#import "PageViewController.h"
#import "AlphaPanManager.h"
#import "PagePushViewController.h"


@interface PageViewController () <PagePushViewControllerDelegate>

@property (nonatomic, strong) AlphaPanManager *pushManager;

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backToRoot)];
    self.navigationItem.leftBarButtonItem = back;
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"翻页效果";
    self.view.backgroundColor = [UIColor whiteColor];
    WEAK(weakSelf);
    _pushManager = [AlphaPanManager managerWithDirection:AlphaPanManagerGestureDirectionLeft type:AlphaPanManagerTypePush];
    _pushManager.pushAction = ^(){
        [weakSelf push];
    };
    [_pushManager addPanGestureToVC:self];
}

- (void)backToRoot
{
    self.navigationController.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)pushAction:(UIButton *)sender {
    [self push];
}


- (void)push {
    PagePushViewController *vc = [PagePushViewController new];
    self.navigationController.delegate = vc;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}


- (id<UIViewControllerInteractiveTransitioning>)animationManagerForPush {
    return _pushManager;
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
