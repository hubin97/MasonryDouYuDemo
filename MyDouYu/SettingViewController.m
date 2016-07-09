//
//  SettingViewController.m
//  MyDouYu
//
//  Created by Hubin_Huang on 16/7/9.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingSectionView.h"

#define kRowHeight 40

@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic ,strong) UITableView *settingTableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WS(ws);
    
//    self.settingTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    self.settingTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];

    [self.view addSubview:self.settingTableView];
    
    [self.settingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsZero);
    }];
    //self.settingTableView.backgroundColor = [UIColor brownColor];
    
    [self.settingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.settingTableView.dataSource = self;
    self.settingTableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SettingSectionView *sectionView = [[SettingSectionView alloc]init];
    sectionView.backgroundColor = [UIColor lightGrayColor];
    switch (section)
    {
            case 0:
        {
            sectionView.titleLabel.text = @"系统设置";
        }
            break;
            case 1:
        {
            sectionView.titleLabel.text = @"直播设置";
        }
            break;
            case 2:
        {
            sectionView.titleLabel.text = @"其他设置";
        }
            break;
        default:
            break;
    }
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kRowHeight;
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
