//
//  RecommendController.m
//  MyDouYu
//
//  Created by Hubin_Huang on 16/6/25.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "RecommendController.h"
#import "SDCycleScrollView.h"


#import "TopAdModel.h"
#import "NewShowModel.h"
#import "ChanelData.h"


#import "RecommendHeadView.h" //段头
#import "NewShowCell.h" //第一个cell
#import "RecommendCell.h"

@interface RecommendController ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dateSourceArray;
    NSMutableArray *_topAdArray;  //广告轮播数据源
    NSMutableArray *_newDataArray;  //新秀数据源
    NSMutableArray *_channelDatas;  //tableView数据源
    
    SDCycleScrollView *_headView;
    UITableView *_tableView;
    
    NSMutableArray *_imageArray;
    NSMutableArray *_titleArray;

}

@property (nonatomic, strong) UICollectionView *onlineCollection;

@end

@implementation RecommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _dateSourceArray = [[NSMutableArray alloc]init];
    _topAdArray = [[NSMutableArray alloc]init];
    _newDataArray = [[NSMutableArray alloc]init];
    _channelDatas = [[NSMutableArray alloc]init];
    
    
    _imageArray = [NSMutableArray array];
    _titleArray = [NSMutableArray array];
    
    
    [self loadChanelData];

    [self requestADData];
    [self loadNewShowData];
    
    
    [self initHeadView];
    [self initTableView];
    
 
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsCompact];
}

-(void)initTableView
{
    WS(ws);

    //CGRectMake(0, 0, kScreenW, kScreenH-64-self.tabBarController.tabBar.frame.size.height)
    _tableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_tableView];

    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(ws.view);
        //make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(/*ws.navigationController.navigationBar.frame.size.height + 20*/ 0, 0, ws.tabBarController.tabBar.frame.size.height, 0));
    }];
    
    //DrawBorderForView(_tableView, 1.0, redColor);
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableHeaderView=_headView;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[RecommendCell class] forCellReuseIdentifier:@"recommendCell"];
    
}

-(void)initHeadView
{
    
    _headView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenW  , kScreenW/2) imagesGroup:_imageArray];
    _headView.titlesGroup=_titleArray;
    _headView.placeholderImage=[UIImage imageNamed:@"Img_default"];
    _headView.delegate=self;
    _headView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _headView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    _headView.titleLabelTextFont=[UIFont systemFontOfSize:17];
    
    //DrawBorderForView(_headView, 2, blueColor);
}

//请求广告头
- (void)requestADData
{
    //默认图片 Image_no_data
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = TOP_URl;
    
    //获取时间戳
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    
    
    NSDictionary *parameteiDic=@{@"aid":@"ios",@"auth":@"97d9e4d3e9dfab80321d11df5777a107",@"client_sys":@"ios",@"time":timeString};
    
    [manager GET:url parameters:parameteiDic progress:^(NSProgress * _Nonnull downloadProgress) {
        //Progress
        //NSLog(@"task: downloadProgress = %@", downloadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"task = %@; responseObject = %@",task,responseObject);
        //_dateSourceArray = [OnlineModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        
        _topAdArray = [TopAdModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        
        for (TopAdModel *topAdModel in _topAdArray)
        {
            [_imageArray addObject:topAdModel.pic_url];
            [_titleArray addObject:topAdModel.title];
        }
        
        _headView.imageURLStringsGroup=_imageArray;
        _headView.titlesGroup=_titleArray;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"task = %@; error = %@",task, error);
    }];
    
}


-(void)loadNewShowData
{
    //默认图片 Image_no_data
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //获取时间戳
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSString *url = [NSString stringWithFormat:@"%@%@",NEW_URl,timeString];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //Progress
        //NSLog(@"task: downloadProgress = %@", downloadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"task = %@; responseObject = %@",task,responseObject);
        _newDataArray = [NewShowModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        NSLog(@"_newDataArray = %@",_newDataArray);

        NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:0];//刷新
        [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"task = %@; error = %@",task, error);
    }];

}

-(void)loadChanelData
{
    //[self showLoadView];
    
   
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a =[date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSString *url=[NSString stringWithFormat:@"%@%@",CHANEL_URl,timeString];

    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSLog(@"responseObject: =%@",responseObject);
        //NSLog(@"responseObject data: =%@",[responseObject objectForKey:@"data"]);

        for (NSDictionary *dic in [responseObject objectForKey:@"data"])
        {
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            [arr addObject:dic[@"title"]];
            [arr addObject:dic[@"cate_id"]];
            [arr addObject:[ChanelData mj_objectArrayWithKeyValuesArray:dic[@"roomlist"]]];
            
            [_channelDatas addObject:arr];
        }
        
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"task = %@; error = %@",task, error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - date source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_channelDatas count])
    {
        return [_channelDatas count];
    }
    else
    {
        return 1;
    }
    
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        static NSString *identfire=@"newShowCell";
        
        NewShowCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
        
        if (!cell) {
            
            cell=[[NewShowCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfire];
            
            [cell setContentViewWithArrays:_newDataArray];
        }
        
        //???
        return cell;
    }
    
    static NSString *identfire2 = @"recommendCell";
    
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:identfire2];
    
    if (!cell) {
        
        cell=[[RecommendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfire2];
    }
    
    //NSLog(@"_channelDatas[indexPath.section - 1]:%@",_channelDatas[indexPath.section - 1]);
    /**
     _channelDatas[indexPath.section - 1]:(
     "\U5143\U6c14\U9886\U57df",
     "homechannel_yqly",
     (
     "<ChanelData: 0x7fe59159b590>",
     "<ChanelData: 0x7fe5917d8d90>",
     "<ChanelData: 0x7fe5917d9290>",
     "<ChanelData: 0x7fe5917d9770>"
     )
     )
     */
    [cell setContentViewWithModelArrs:_channelDatas[indexPath.section - 1][2]];

    return cell;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
//    TOPdata *topdata=_topDataArray[index];
//    
//    PlayerController *playVC=[[PlayerController alloc]init];
//    
//    NSLog(@"%@",[topdata.room objectForKey:@"hls_url"]);
//    
//    playVC.Hls_url=[topdata.room objectForKey:@"hls_url"];
    
    [self setHidesBottomBarWhenPushed:YES];
//    [self presentViewController:playVC animated:YES completion:nil];
    
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    RecommendHeadView *headView = [[RecommendHeadView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 30 *K5SWScale)];
    headView.isHiddenRightView = NO;
    headView.sectionTitleLabel.font = [UIFont systemFontOfSize:15.0];
    
    //DrawBorderForView(headView, 1.0, redColor);

    if (section == 0)
    {
        headView.sectionTitleLabel.text = @"新秀推荐";
    }
    else
    {
        if ([_channelDatas count])
        {
            //NSLog(@"title:%@",_channelDatas[section][0][@"title"]);
            NSLog(@"title:%@",[_channelDatas[section - 1] firstObject]);
            headView.sectionTitleLabel.text = [_channelDatas[section - 1] firstObject];
            
        }
    }
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 180 *K5SWScale;
    }
    else
    {
        return 220 *K5SWScale;
    }
    
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0)
//    {
//        return 150 *K5SWScale;
//    }
//    else
//    {
//        return 90;
//    }
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30 *K5SWScale;
}

#warning 取消Plain粘性效果,Grouped去掉头部和中间间隔
/**
 UITableViewStylePlain 有多段时 段头停留（自带效果）
 UITableViewStyleGrouped  不会有以上效果
 
 //文／Developer_峰（简书作者）
 //原文链接：http://www.jianshu.com/p/3a5063993368
 //著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。
 
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    CGFloat sectionHeaderHeight = 30;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
}

//
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
