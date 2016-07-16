//
//  SettingViewController.m
//  MyDouYu
//
//  Created by Hubin_Huang on 16/7/9.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingSectionView.h"

#import "SettingSwitchCell.h"
#import "SettingSliderCell.h"

#define kRowHeight 40

@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    SettingSectionView *_sectionView;
    
    
    CGFloat adjustAlpha;
    CGFloat adjustFont;
    
}
@property (nonatomic ,strong) UITableView *settingTableView;

@end

@implementation SettingViewController

#pragma mark - Setup
- (void)initNavi
{
    self.title = @"设置";
    
    self.navigationItem.hidesBackButton = YES;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"btn_nav_back"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"btn_nav_back_click"] forState:UIControlStateHighlighted];
    backBtn.frame=CGRectMake(0, 0, 25, 25);
    [backBtn addTarget:self action:@selector(CloseSetting) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

}

- (void)initTableView
{
    WS(ws);
    
    self.settingTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    [self.view addSubview:self.settingTableView];
    
    [self.settingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsZero);
    }];
    //self.settingTableView.backgroundColor = [UIColor brownColor];
    
    //假数据
    [self.settingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.settingTableView registerClass:[SettingSwitchCell class] forCellReuseIdentifier:@"switchCell"];
    
    [self.settingTableView registerClass:[SettingSliderCell class] forCellReuseIdentifier:@"sliderCell"];

    
    self.settingTableView.dataSource = self;
    self.settingTableView.delegate = self;
}

#pragma mark - View Life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavi];
   
    [self initTableView];
    
    [self initDataSource];
   
}

- (void)initDataSource
{
    adjustAlpha = 1.0f;
    adjustFont  = 15.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event, Callbacks
- (void)CloseSetting
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Delegate And DataSource
#pragma mark - table data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 3;
    switch (section)
    {
        case 0:
            return 1;  //系统设置
            break;
        case 1:
            return 9;  //直播设置
            break;
        case 2:
            return 4;  //其他设置
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * switchCellIdentifier = @"switchCell";
    static NSString * sliderCellIdentifier = @"sliderCell";
    
    NSArray *otherSetArr = @[@"消息通知",@"清理缓存",@"关于我们",@"给我们评分"];

    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    
    SettingSwitchCell *switchCell = [tableView dequeueReusableCellWithIdentifier:switchCellIdentifier];
    [switchCell awakeFromNib];
    
    
    SettingSliderCell *sliderCell = [tableView dequeueReusableCellWithIdentifier:sliderCellIdentifier];
    [sliderCell awakeFromNib];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f * K5SWScale];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.section)
    {
        case 0:
        {
            switchCell.titleLabel.text = @"列表自动加载";
            return switchCell;
        }
            break;
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    switchCell.titleLabel.text = @"播放器手势";
                    return switchCell;
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"弹幕君今天没💊,感觉萌萌哒";
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
                    //直接重写textlabel的位置
                    [cell.textLabel mas_updateConstraints:^(MASConstraintMaker *make){
                        make.center.equalTo(cell.contentView);
                    }];
                    
                    cell.textLabel.alpha = adjustAlpha;
                    cell.textLabel.font  = [UIFont systemFontOfSize:adjustFont];

                    return cell;
                }
                    break;
                case 2:
                {
                    cell.textLabel.text = @"弹幕透明度";
                    cell.textLabel.textAlignment = NSTextAlignmentLeft;
                    return cell;
                }
                    break;
                case 3:
                {
                 //t - T
                    sliderCell.smallImgView.image = [UIImage imageNamed:@"Image_alpha_small"];
                    sliderCell.bigImgView.image = [UIImage imageNamed:@"Image_alpha_big"];
                    [sliderCell.setSlider setValue:1.0];
                    sliderCell.setSlider.tintColor = [UIColor redColor];
                    [sliderCell.setSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
                    sliderCell.setSlider.tag = indexPath.row;
                    return sliderCell;
                }
                    break;
                case 4:
                    cell.textLabel.text = @"弹幕字号";
                    cell.textLabel.textAlignment = NSTextAlignmentLeft;
                    return cell;
                    break;
                case 5:
                {
                    //a - A
                    sliderCell.smallImgView.image = [UIImage imageNamed:@"Image_font_small"];
                    sliderCell.bigImgView.image = [UIImage imageNamed:@"Image_font_big"];
                    sliderCell.setSlider.tintColor = [UIColor redColor];
                    [sliderCell.setSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
                    sliderCell.setSlider.tag = indexPath.row;
                    
                    [sliderCell.setSlider setMinimumValue:1.0];
                    [sliderCell.setSlider setMaximumValue:2.0];
                    [sliderCell.setSlider setValue:adjustFont/12];

                    return sliderCell;
                }
                    break;
                case 6:
                {
                    cell.textLabel.text = @"弹幕位置";
                    cell.textLabel.textAlignment = NSTextAlignmentLeft;
                    return cell;
                }
                    break;
                case 7:
                {
                    //cell.textLabel.text = @"z x c";
                    //cell.textLabel.textAlignment = NSTextAlignmentLeft;
                    
                    return cell;
                }
                    break;
                case 8:
                {
                    cell.textLabel.text = @"休眠设置";
                    cell.textLabel.textAlignment = NSTextAlignmentLeft;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    return cell;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == 0)
            {
                switchCell.textLabel.text = otherSetArr[indexPath.row];
                return switchCell;
            }
            else
            {
                cell.textLabel.text = otherSetArr[indexPath.row];
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                if (indexPath.row == 1)
                {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.detailTextLabel.text = @"6.66Mb";
                }
                else
                {
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                return cell;
            }
        }
            break;
        default:
            break;
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
#warning 自定义子控件如何返回flodbutton的select状态?
    _sectionView = [[SettingSectionView alloc]init];
    _sectionView.backgroundColor = COLOR(239, 239, 244, 1);
    _sectionView.titleLabel.textColor = [UIColor grayColor];
    
    NSArray *sectionTitleArr = @[@"系统设置",@"直播设置",@"其他设置"];
    
    _sectionView.titleLabel.text = sectionTitleArr[section];

    return _sectionView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kRowHeight;
}

- (void)sliderValueChange:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    NSLog(@"slider.tag = %ld, slider.value = %.2f",(long)slider.tag,slider.value);
    //3/5
    switch (slider.tag)
    {
        case 3:
            adjustAlpha = slider.value;
            break;
        case 5:
            adjustFont  = 12 * K5SWScale * slider.value;
            break;
            
        default:
            break;
    }
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    [self.settingTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
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
