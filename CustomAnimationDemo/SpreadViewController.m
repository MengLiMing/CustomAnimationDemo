//
//  SpreadViewController.m
//  CustomAnimationDemo
//
//  Created by my on 16/4/2.
//  Copyright © 2016年 base. All rights reserved.
//

#import "SpreadViewController.h"
#import "PureLayout.h"

#import "SpreadModelViewController.h"

@interface SpreadViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation SpreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [UIImageView newAutoLayoutView];
    [imageView setImage:[UIImage imageNamed:@"pageTwo"]];
    [self.view addSubview:imageView];
    [imageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [imageView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [imageView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [imageView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.button];
    
    [_button setTitle:@"点击或\n拖动我" forState:UIControlStateNormal];
    _button.titleLabel.numberOfLines = 0;
    _button.titleLabel.textAlignment = 1;
    _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _button.titleLabel.font = [UIFont systemFontOfSize:11];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    _button.backgroundColor = [UIColor grayColor];
    _button.layer.cornerRadius = 20;
    _button.layer.masksToBounds = YES;

    [_button autoSetDimensionsToSize:CGSizeMake(40, 40)];
    [_button autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    [_button autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(SCREEN_WIDTH - 40)/2];
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [_button addGestureRecognizer:pan];
}

- (CGRect)buttonFrame {
    return _button.frame;
}

- (void)present {
    SpreadModelViewController *vc  = [[SpreadModelViewController alloc] init];
    vc.transitioningDelegate = vc;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)pan:(UIPanGestureRecognizer *)panGesture{
    UIView *button = panGesture.view;
    NSLog(@"%@",NSStringFromCGPoint([panGesture translationInView:panGesture.view]));

    CGPoint newCenter = CGPointMake([panGesture translationInView:panGesture.view].x + button.center.x, [panGesture translationInView:panGesture.view].y + button.center.y);
    _button.translatesAutoresizingMaskIntoConstraints = YES;
    _button.center = newCenter;
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
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
