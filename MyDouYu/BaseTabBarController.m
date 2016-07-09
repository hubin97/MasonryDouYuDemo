//
//  BaseTabBarController.m
//  MyDouYu
//
//  Created by Mac on 16/6/21.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "BaseTabBarController.h"

#import "RecommendController.h"  //推荐
#import "ColumnController.h"     //栏目
#import "OnlineViewController.h" //直播
#import "MineController.h"       //我的

#import "BaseNavigationController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tabBar];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tabBar.tintColor = TabBar_T_Color;

    [self initChildViewControllers];
}


- (void)initChildViewControllers
{
    //推荐
    RecommendController *recommend = [[RecommendController alloc]init];
    recommend.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"推荐" image:[UIImage imageNamed:@"btn_home_normal"] selectedImage:[UIImage imageNamed:@"btn_home_selected"]];
    BaseNavigationController *recommendNavi = [[BaseNavigationController alloc]initWithRootViewController:recommend];
    
    //栏目
    ColumnController *column = [[ColumnController alloc]init];
    column.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"栏目" image:[UIImage imageNamed:@"btn_column_normal"] selectedImage:[UIImage imageNamed:@"btn_column_selected"]];
    BaseNavigationController *columnNavi = [[BaseNavigationController alloc]initWithRootViewController:column];
    
    //直播
    OnlineViewController *online = [[OnlineViewController alloc]init];
    online.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"直播" image:[UIImage imageNamed:@"btn_online_normal"] selectedImage:[UIImage imageNamed:@"btn_online_selected"]];
    BaseNavigationController *onlineNavi = [[BaseNavigationController alloc]initWithRootViewController:online];
    
    //我的
    MineController *mine = [[MineController alloc]init];
    mine.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"btn_mine_normal"] selectedImage:[UIImage imageNamed:@"btn_mine_selected"]];
    BaseNavigationController *mineNavi = [[BaseNavigationController alloc]initWithRootViewController:mine];
    
    //self.toolbarItems = @[recommendItem,columnItem,onlineItem,mineItem];
    self.viewControllers = @[recommendNavi,columnNavi,onlineNavi,mineNavi];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
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
