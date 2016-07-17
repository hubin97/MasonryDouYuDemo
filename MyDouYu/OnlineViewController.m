//
//  OnlineViewController.m
//  MyDouYu
//
//  Created by Hubin_Huang on 16/6/25.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "OnlineViewController.h"
#import "OnlineCollectionCell.h"
#import "OnlineModel.h"


@interface OnlineViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_dateSourceArray;
    int times; //记录上拉的次数
}

@property (nonatomic, strong) UICollectionView *onlineCollection;

@end

@implementation OnlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    times=0;

    [self initCollectionView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestData];
    
    [self loadMoreData];

}
- (void)requestData
{
    //网络请求
    //默认图片 Image_no_data
    _dateSourceArray = [[NSMutableArray alloc]init];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@&offset=%@&time=%@",OnlineURL,OnlineURL_a,OnlineURL_b];
    
    //manager.baseURL = [manager initWithBaseURL:[NSURL URLWithString:url]];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //Progress
        //NSLog(@"task: downloadProgress = %@", downloadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"task = %@; responseObject = %@",task, responseObject);
        _dateSourceArray = [OnlineModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        
        [self.onlineCollection reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"task = %@; error = %@",task, error);
    }];
    
    
}

-(void)loadMoreData
{

    self.onlineCollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"%@&offset=%@&time=%@",OnlineURL,OnlineURL_a,OnlineURL_b];
        
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            _dateSourceArray = [OnlineModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            
            [self.onlineCollection reloadData];
            [self.onlineCollection.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.onlineCollection.mj_header endRefreshing];

        }];
    }];
    
    [self.onlineCollection.mj_header beginRefreshing];
    
    
    
    self.onlineCollection.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        times += 20;
        NSString *time = [NSString stringWithFormat:@"%d",times];
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"%@&offset=%@&time=%@",OnlineURL,time,OnlineURL_b];
        
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *array = [OnlineModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            
            for (OnlineModel *moreData in array) {
                
                [_dateSourceArray addObject:moreData];
            }
            
            [self.onlineCollection reloadData];
            [self.onlineCollection.mj_footer endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.onlineCollection.mj_footer endRefreshing];
            
        }];
    }];
    
    self.onlineCollection.mj_footer.hidden = YES;
    
}


- (void)initCollectionView
{
    WS(ws);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    int col = 2;   //2列
    CGFloat padding = 5 * K5SWScale; 
    CGFloat itemSize = ([[UIScreen mainScreen] bounds].size.width - (col + 1) *padding)/col;
    //CGFloat itemSize = ([[UIScreen mainScreen] bounds].size.width - col *padding)/col;

    NSLog(@"itemSize = %.2f",itemSize);
    
    flowLayout.itemSize = CGSizeMake(itemSize, itemSize/(1.5));
    flowLayout.minimumLineSpacing = padding;
    flowLayout.minimumInteritemSpacing = padding;
    
    //设置整个段的边框与屏幕的间距
    flowLayout.sectionInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    
    self.onlineCollection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.onlineCollection.backgroundColor = [UIColor whiteColor];
    
    [self.onlineCollection registerClass:[OnlineCollectionCell class] forCellWithReuseIdentifier:@"onlineCell"];
    
    [self.onlineCollection setDataSource:self];
    [self.onlineCollection setDelegate:self];
    
    //DrawBorderForView(self.onlineCollection, 2, redColor);
    
    NSLog(@"@@");
    
    [self.view addSubview:self.onlineCollection];
    
    [self.onlineCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(ws.view);
        //make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dateSourceArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"onlineCell";
   
    OnlineCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    [cell setOnlineData:_dateSourceArray[indexPath.item]];
    
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 5.0f;
    
    DrawBorderForView(cell, 1, brownColor);
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath = %@",indexPath);
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
