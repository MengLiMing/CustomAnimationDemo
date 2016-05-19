//
//  PresentDemo1ViewController.m
//  CustomAnimationDemo
//
//  Created by my on 16/3/30.
//  Copyright © 2016年 base. All rights reserved.
//

#import "PresentDemo1ViewController.h"
#import "UIButton+Category.h"
#import "ModelDemo1ViewController.h"

#import "DemoOnePresentAnimation.h"

#import "DemoOneSwipeInteractive.h"
#import "DemoOneDismissAnimation.h"

@interface PresentDemo1ViewController () <ModelDemo1ViewControllerDelegate,UIViewControllerTransitioningDelegate>
{
    UIImageView *topImage;
}
@property (nonatomic, strong) DemoOnePresentAnimation *presentAnimation;
@property (nonatomic, strong) DemoOneDismissAnimation *dismissAnimation;
@property (nonatomic, strong) DemoOneSwipeInteractive *transitionController;

@end

@implementation PresentDemo1ViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //无交互
        _presentAnimation = [DemoOnePresentAnimation new];
        
        //交互
        _dismissAnimation = [DemoOneDismissAnimation new];
        _transitionController = [DemoOneSwipeInteractive new];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    // Do any additional setup after loading the view.
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
        ModelDemo1ViewController *mvc = [[ModelDemo1ViewController alloc] init];
        mvc.delegate = self;
        //无交互
        mvc.transitioningDelegate = self;

        //交互
        [self.transitionController wireToViewController:mvc];
        UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController:mvc];
        [self presentViewController:vc animated:YES completion:nil];

        
    }];
    [self.view addSubview:button];
}


#pragma mark - ModelDemo1ViewControllerDelegate
- (void)modelViewControllerDidClockedDismissbutton:(ModelDemo1ViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.presentAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissAnimation;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.transitionController.interacting ? self.transitionController : nil;
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
