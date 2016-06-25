//
//  BaseViewController.m
//  MyDouYu
//
//  Created by Hubin_Huang on 16/6/25.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //WS(ws);
    
    CGFloat iconSize = 25 *K5SWScale;
    UIButton * qrCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qrCodeBtn.frame=CGRectMake(0, 0, iconSize, iconSize);
    [qrCodeBtn setImage:[UIImage imageNamed:@"Image_scan"] forState:UIControlStateNormal];
    [qrCodeBtn setImage:[UIImage imageNamed:@"Image_scan_click"] forState:UIControlStateHighlighted];
    [qrCodeBtn addTarget:self action:@selector(QRCode:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(0, 0, iconSize, iconSize);
    [searchBtn setImage:[UIImage imageNamed:@"btn_search"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"btn_search_clicked"] forState:UIControlStateHighlighted];
    [searchBtn addTarget:self action:@selector(Search:) forControlEvents:UIControlEventTouchUpInside];
    

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:qrCodeBtn];;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    
    
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 104 *K5SWScale, 28 *K5SWScale)];
    titleImageView.image = [UIImage imageNamed:@"logo"];
    self.navigationItem.titleView = titleImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Action
- (void)QRCode:(id)sender
{
    NSLog(@"QRCode!!!");
}

- (void)Search:(id)sender
{
    NSLog(@"Search!!!");
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
