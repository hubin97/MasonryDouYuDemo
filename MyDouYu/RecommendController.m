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


#import "NewShowCell.h"

@interface RecommendController ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dateSourceArray;
    NSMutableArray *_topAdArray;
    NSMutableArray *_newDataArray;

    
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
    
    _imageArray = [NSMutableArray array];
    _titleArray = [NSMutableArray array];
    
    
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
    _tableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];

    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(ws.view);
        //make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(/*ws.navigationController.navigationBar.frame.size.height + 20*/ 0, 0, ws.tabBarController.tabBar.frame.size.height, 0));
    }];
    
    DrawBorderForView(_tableView, 1.0, redColor);
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableHeaderView=_headView;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"recommendCell"];
    
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
    
    DrawBorderForView(_headView, 2, blueColor);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - date source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        static NSString *identfire=@"newShowCell";
        
        NewShowCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
        
        if (!cell) {
            
            cell=[[NewShowCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfire];
        }
        
        //[cell setContentView:_newDataArray];
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommendCell"];
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
