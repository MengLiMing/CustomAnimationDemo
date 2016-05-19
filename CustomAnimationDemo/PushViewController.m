//
//  PushViewController.m
//  CustomAnimationDemo
//
//  Created by my on 16/3/31.
//  Copyright © 2016年 base. All rights reserved.
//

#import "PushViewController.h"
#import "Masonry.h"
#import "UIView+FrameChange.h"

#import "AlphaPanManager.h"
#import "NavAnimation.h"

@interface PushViewController ()
@property (nonatomic, strong) AlphaPanManager *interactiveTransition;

@end

@implementation PushViewController
- (void)dealloc {
    NSLog(@"销毁了");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"cell push";
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellImage"]];
    self.imageView = imageView;
    [self.view addSubview:self.imageView];
    imageView.center = CGPointMake(self.view.center.x, self.view.center.y - self.view.height / 2 + 210);
    imageView.bounds = CGRectMake(0, 0, 280, 280);
    UITextView *textView = [UITextView new];
    textView.text = @"这是类似于KeyNote的神奇移动效果，向右滑动可以通过手势控制POP动画";
    textView.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textView];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero).priorityLow();
        make.top.mas_equalTo(imageView.mas_bottom).offset(20);
    }];
    
    _interactiveTransition = [AlphaPanManager managerWithDirection:AlphaPanManagerGestureDirectionRight type:AlphaPanManagerTypePop];
    [_interactiveTransition addPanGestureToVC:self];
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return [NavAnimation transitionWithType:operation == UINavigationControllerOperationPush ? NavAnimationPush : NavAnimationPop];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return _interactiveTransition.interactiving?_interactiveTransition:nil;
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
