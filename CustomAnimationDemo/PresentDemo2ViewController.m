//
//  PresentDemo2ViewController.m
//  CustomAnimationDemo
//
//  Created by my on 16/3/30.
//  Copyright © 2016年 base. All rights reserved.
//

#import "PresentDemo2ViewController.h"
#import "UIButton+Category.h"
#import "ModelDemo2ViewController.h"
#import "PresentDismissTransition.h"

#import "MLMInteractiveTransition.h"

@interface PresentDemo2ViewController () <ModelDemo2ViewControllerDelegate,UIViewControllerTransitioningDelegate>
{
    UIImageView *topImage;
}
@property (nonatomic, strong) MLMInteractiveTransition *interactivePresent;
@property (nonatomic, strong) MLMInteractiveTransition *interactiveDismiss;

@end

@implementation PresentDemo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"弹性present";
    self.view.backgroundColor = [UIColor redColor];
    
    UIImage *headImage = [UIImage imageNamed:@"headerImage"];
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 74, SCREEN_WIDTH - 20,(SCREEN_WIDTH - 20)*headImage.size.height/headImage.size.width)];
    [topImage setImage:headImage];
    topImage.layer.cornerRadius = 5;
    topImage.layer.masksToBounds = YES;
    [self.view addSubview:topImage];
    
    UIButton *button = [UIButton createButtonWithFrame:CGRectMake(0, topImage.frame.origin.y + topImage.frame.size.height + 20, SCREEN_WIDTH, 40)
                                                 Title:@"点我present"
                                          normaleImage:nil
                                           selectImage:nil
                                       backGroundColor:[UIColor whiteColor]
                                            titleColor:[UIColor blackColor]
                                             titleFont:[UIFont systemFontOfSize:14]
                                            buttonType:UIButtonTypeCustom];
    [button handleContentEvent:UIControlEventTouchUpInside withBlock:^{
        [self present];
    }];
    [self.view addSubview:button];
    
    __weak typeof(self) weakself = self;
    _interactivePresent = [MLMInteractiveTransition
                        interactiveTransitionWithTransitionType:MLMInteractiveTranstionTypePresent
                                            GestureDirection:MLMInteractiveTranstionGestureDirectionUp];
    _interactivePresent.presentAction = ^(){
        [weakself present];
    };
    [_interactivePresent addPanGestureForViewController:self];
}



- (void)present {
    ModelDemo2ViewController *vc = [[ModelDemo2ViewController alloc] init];
    vc.delegate = self;
    vc.transitioningDelegate = self;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    _interactiveDismiss = [MLMInteractiveTransition
                           interactiveTransitionWithTransitionType:MLMInteractiveTranstionTypeDismiss
                           GestureDirection:MLMInteractiveTranstionGestureDirectionDown];
    [_interactiveDismiss addPanGestureForViewController:vc];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - ModelDemo2ViewControllerDelegate
- (void)clickButtonAndDismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [PresentDismissTransition transitionWithTransitionType:PresentDimissTransitonPresent animationName:PresentDimissAnimationType3D];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [PresentDismissTransition transitionWithTransitionType:PresentDimissTransitonDismiss animationName:PresentDimissAnimationType3D];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interactiveDismiss.interation ? _interactiveDismiss : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interactivePresent.interation ? _interactivePresent : nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
