//
//  PagePushViewController.m
//  CustomAnimationDemo
//
//  Created by my on 16/3/31.
//  Copyright © 2016年 base. All rights reserved.
//

#import "PagePushViewController.h"
#import "PagePushAnimation.h"
#import "AlphaPanManager.h"

@interface PagePushViewController ()

@property (nonatomic, strong) AlphaPanManager *popManager;
@property (nonatomic, assign) UINavigationControllerOperation operation;

@end

@implementation PagePushViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"翻页效果";
    self.view.backgroundColor = [UIColor grayColor];
    self.view.frame = [UIScreen mainScreen].bounds;
    _popManager = [AlphaPanManager managerWithDirection:AlphaPanManagerGestureDirectionRight type:AlphaPanManagerTypePop];
    [_popManager addPanGestureToVC:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popAction:(UIButton *)sender {
    
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    
    [self pop];
}


- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    _operation = operation;
    return [PagePushAnimation animationWith:operation == UINavigationControllerOperationPush ? PagePushAnimationTypePush : PagePushAnimationTypePop];
}


- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if (_operation == UINavigationControllerOperationPush) {
        AlphaPanManager *manager = [_delegate animationManagerForPush];
        return manager.interactiving ? manager : nil;
    } else {
        return _popManager.interactiving ? _popManager : nil;
    }
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
