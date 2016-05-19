//
//  ParentViewController.m
//  CustomAnimationDemo
//
//  Created by my on 16/3/29.
//  Copyright © 2016年 base. All rights reserved.
//

#import "ParentViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "MLMSegmentView.h"

@interface ParentViewController ()

@property (nonatomic, strong) FirstViewController  *firstVC;
@property (nonatomic, strong) SecondViewController *secondVC;
@property (nonatomic, strong) ThirdViewController  *thirdVC;

@property (nonatomic, strong) UIViewController *currentVC;

@property (nonatomic, strong) MLMSegmentView *headScrollView;

@property (nonatomic, strong) NSArray *headArray;

@end

@implementation ParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"网易新闻Demo";
    self.headArray = @[@"头条",@"娱乐",@"体育",@"财经",@"科技",@"NBA",@"手机",@"旅游",@"搞笑"];
    WEAK(weakself);
    self.headScrollView = [[MLMSegmentView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40) withSource:self.headArray];
    self.headScrollView.chooseTap = ^(NSInteger index) {
        [weakself actionWith:index];
    };
    [self.view addSubview:self.headScrollView];

    
    
    [self addVC];
    // Do any additional setup after loading the view.
}

//addChildViewController
- (void)addVC {
    /*
     苹果新的API增加了addChildViewController方法，并且希望我们在使用addSubview时，同时调用[self addChildViewController:child]方法将sub view对应的viewController也加到当前ViewController的管理中。
     对于那些当前暂时不需要显示的subview，只通过addChildViewController把subViewController加进去；需要显示时再调用transitionFromViewController方法。将其添加进入底层的ViewController中。
     这样做的好处：
     
     1.无疑对页面中的逻辑更加分明了。相应的View对应相应的ViewController。
     2.当某个子View没有显示时，将不会被Load，减少了内存的使用。
     3.当内存紧张时，没有Load的View将被首先释放，优化了程序的内存释放机制。
     */
    
    /**
     *  在iOS5中，ViewController中新添加了下面几个方法：
     *  addChildViewController:
     *  removeFromParentViewController
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  willMoveToParentViewController:
     *  didMoveToParentViewController:
     */
    self.firstVC = [[FirstViewController alloc] init];
    [self.firstVC.view setFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT - 104)];
    [self addChildViewController:_firstVC];
    
    self.secondVC = [[SecondViewController alloc] init];
    [self.secondVC.view setFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT - 104)];
    
    self.thirdVC = [[ThirdViewController alloc] init];
    [self.thirdVC.view setFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT - 104)];
    
    
    //默认，第一个视图
    [self.view addSubview:self.firstVC.view];
    self.currentVC = self.firstVC;
}

#pragma mark - 点击事件
- (void)actionWith:(NSInteger)index {
    if ((self.currentVC == self.firstVC && index == 0)||(self.currentVC == self.secondVC && index == 1)) {
        return;
    } else {
        switch (index) {
            case 0:
            {
                [self replaceController:self.currentVC newController:self.firstVC];
            }
                break;
            case 1:
            {
                [self replaceController:self.currentVC newController:self.secondVC];
            }
                break;
            case 2:
            {
                
            }
                break;
            case 3:
            {
                
            }
                break;
            case 4:
            {
                
            }
                break;
            case 5:
            {
                
            }
                break;
            case 6:
            {
                
            }
                break;
            case 7:
            {
                
            }
                break;
            case 8:
            {
                
            }
                break;
                
            default:
                break;
        }
    }
}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController {
    /**
     *			着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController	  当前显示在父视图控制器中的子视图控制器
     *  toViewController		将要显示的子视图控制器
     *  duration				动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options				 动画效果(渐变,从下往上等等,具体查看API)
     *  animations			  转换过程中得动画
     *  completion			  转换完成
     */
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:2 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        
    } completion:^(BOOL finished) {
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
            
        }else{
            
            self.currentVC = oldController;
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//UIViewAnimationOptionTransitionNone            
//UIViewAnimationOptionTransitionFlipFromLeft //左右旋转
//UIViewAnimationOptionTransitionFlipFromRight //左右旋转
//UIViewAnimationOptionTransitionCurlUp  //翻页效果⬆️
//UIViewAnimationOptionTransitionCurlDown //翻页效果⬇️
//UIViewAnimationOptionTransitionCrossDissolve  //颜色渐变
//UIViewAnimationOptionTransitionFlipFromTop  //上下旋转
//UIViewAnimationOptionTransitionFlipFromBottom  //上下旋转
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
