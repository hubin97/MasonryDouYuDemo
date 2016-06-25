//
//  MineController.m
//  MyDouYu
//
//  Created by Hubin_Huang on 16/6/25.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "MineController.h"
#import "MineFirstCell.h"

@interface MineController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mineTableView;
@property (nonatomic, strong) NSArray *dataSourceArr;

@end


@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initDataSource];
    
  
    [self initTableView];
 
}

- (void)initTableView
{
    WS(ws);
    
    ws.view.backgroundColor = [UIColor grayColor];
    
    self.mineTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.mineTableView];
    
    [self.mineTableView registerClass:[MineFirstCell class] forCellReuseIdentifier:@"mineFirstCell"];
    //self.m
    [self.mineTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mineCell"];
    
    [self.mineTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(64, 0, 49, 0));
        make.top.and.bottom.left.right.equalTo(ws.view);
        
    }];
    
    NSLog(@"self.mineTableView: %@",self.mineTableView);
    
    self.mineTableView.dataSource = self;
    self.mineTableView.delegate = self;
}

- (void)initDataSource
{
      self.dataSourceArr = @[@[@"Image_focus.png",@"我的关注"],@[@"Image_history.png",@"观看历史"],@[@"Image_handle.png",@"我的任务"],@[@"Image_remind.png",@"开播提醒"],@[@"Image_set.png",@"系统设置"],@[@"Image_recommend.png",@"精彩推荐"]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"设备触发旋转!!!");
    //触发旋转时更新Cell的布局
    [self.mineTableView reloadData];
}

#pragma mark -table date source  delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 2)
    {
        return 1;
    }
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 80 * K5SWScale;
    }
    else
    {
        return 50 * K5SWScale;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineFirstCell *firstCell = [[MineFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mineFirstCell"];
    
    [firstCell awakeFromNib];
    
 
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mineCell"];
    
    switch (indexPath.section) {
        case 0:
        {
            firstCell.headerImageView.image = [UIImage imageNamed:@"Image_head"];
            firstCell.userInteractionEnabled = YES;
            firstCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return firstCell;
        }
            break;
        case 1:
        {
            NSArray *array = [self.dataSourceArr objectAtIndex:[indexPath row]];
            
            cell.imageView.image = [UIImage imageNamed:array[0]];
            cell.textLabel.text = array[1];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
        }
            break;
        case 2:
        {
            NSArray *array = [self.dataSourceArr lastObject];
            cell.imageView.image = [UIImage imageNamed:array[0]];
            cell.textLabel.text = array[1];
            cell.detailTextLabel.text = @"更多鱼丸等你来拿";
            //cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0 * K5SWScale];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
        }
            break;
        default:
            break;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section)
    {
        case 0:
        {
            NSLog(@"请登录!!!");
        }
            break;
        case 1:
        {
            NSArray *array = self.dataSourceArr[indexPath.row];
            NSLog(@"%@!!!",array[1]);
        }
            break;
        case 2:
        {
            NSArray *array = [self.dataSourceArr lastObject];
            NSLog(@"%@!!!",array[1]);
        }
            break;
        default:
            break;
    }

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
