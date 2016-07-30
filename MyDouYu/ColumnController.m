//
//  ColumnController.m
//  MyDouYu
//
//  Created by Hubin_Huang on 16/6/25.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "ColumnController.h"

#import "ColumnCell.h"
#import "ColumnModel.h"

@interface ColumnController ()<UICollectionViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_dateSourceArray;
//    int times; //记录上拉的次数
}

@property (nonatomic, strong) UICollectionView *columnCollection;

@end

@implementation ColumnController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initCollectionView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestData];
    
    //[self loadMoreData];
    
}
- (void)requestData
{
    //网络请求
    //默认图片 Image_no_data
    _dateSourceArray = [[NSMutableArray alloc]init];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //NSString *url = [NSString stringWithFormat:@"%@&offset=%@&time=%@",OnlineURL,OnlineURL_a,OnlineURL_b];
    NSString *url = @"http://www.douyutv.com/api/v1/game?aid=ios&auth=3f252c3294b31a61fbdd890a45609549&client_sys=ios&time=1446450360";
    //manager.baseURL = [manager initWithBaseURL:[NSURL URLWithString:url]];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //Progress
        //NSLog(@"task: downloadProgress = %@", downloadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"task = %@; responseObject = %@",task, responseObject);
        _dateSourceArray = [ColumnModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        
        
        [self.columnCollection reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"task = %@; error = %@",task, error);
    }];
    
    
}

- (void)initCollectionView
{
    WS(ws);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    int col = 3;   //2列
    CGFloat padding = 5 * K5SWScale;
    CGFloat itemSize = ([[UIScreen mainScreen] bounds].size.width - (col + 1) *padding)/col;
    //CGFloat itemSize = ([[UIScreen mainScreen] bounds].size.width - col *padding)/col;
    
    NSLog(@"itemSize = %.2f",itemSize);
    
    flowLayout.itemSize = CGSizeMake(itemSize, itemSize * 1.77);
    flowLayout.minimumLineSpacing = padding;
    flowLayout.minimumInteritemSpacing = padding;
    
    //设置整个段的边框与屏幕的间距
    flowLayout.sectionInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    
    self.columnCollection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.columnCollection.backgroundColor = [UIColor whiteColor];
    
    [self.columnCollection registerClass:[ColumnCell class] forCellWithReuseIdentifier:@"columnCell"];
    
    [self.columnCollection setDataSource:self];
    [self.columnCollection setDelegate:self];
    
    //DrawBorderForView(self.onlineCollection, 2, redColor);
    
    NSLog(@"@@");
    
    [self.view addSubview:self.columnCollection];
    
    [self.columnCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(ws.view);
        //make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
}



#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dateSourceArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"columnCell";
    
    ColumnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    [cell setcolumnData:_dateSourceArray[indexPath.item]];
    
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 5.0f;
    
    //DrawBorderForView(cell, 1, brownColor);
    
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
