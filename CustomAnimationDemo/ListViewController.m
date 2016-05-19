//
//  ViewController.m
//  CustomAnimationDemo
//
//  Created by my on 16/3/29.
//  Copyright © 2016年 base. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *listArr;
}
@property (nonatomic, strong) UITableView *maintable;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义转场动画";
    listArr = @[@"addChildViewController",@"present动画",@"cell push",@"翻页 push",@"扩散 present",@"custom Push"];
    [self createView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)createView {
    self.maintable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:0];
    self.maintable.separatorStyle = 0;
    self.maintable.delegate = self;
    self.maintable.dataSource = self;
    [self.view addSubview:self.maintable];
}

#pragma mark - 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.text = listArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .00001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .00001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            UIViewController *vc = [NSClassFromString(@"ParentViewController") new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            UIViewController *vc = [NSClassFromString(@"PrensentViewController") new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 2:
        {
            UIViewController *vc = [NSClassFromString(@"MLMCollectionViewController") new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
  
        }
            break;
        case 3:
        {
            UIViewController *vc = [NSClassFromString(@"PageViewController") new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            UIViewController *vc = [NSClassFromString(@"SpreadViewController") new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
  
        }
            break;
        case 5:
        {
            UIViewController *vc = [NSClassFromString(@"CustomPushViewController") new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
