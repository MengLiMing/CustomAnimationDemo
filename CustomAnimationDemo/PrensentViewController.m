//
//  PrensentViewController.m
//  CustomAnimationDemo
//
//  Created by my on 16/3/30.
//  Copyright © 2016年 base. All rights reserved.
//

#import "PrensentViewController.h"
#import "UIButton+Category.h"

@interface PrensentViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *listArr;
}
@property (nonatomic, strong) UITableView *maintable;
@end

@implementation PrensentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"present动画";
    listArr = @[@"demo1",@"demo2",@"demo3"];
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
            [self.navigationController pushViewController:[NSClassFromString(@"PresentDemo1ViewController") new] animated:YES];
        }
            break;
        case 1:
        {
            [self.navigationController pushViewController:[NSClassFromString(@"PresentDemo2ViewController") new] animated:YES];
            
        }
            break;
        case 2:
        {
            [self.navigationController pushViewController:[NSClassFromString(@"PresentViewController") new] animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
