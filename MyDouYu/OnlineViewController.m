//
//  OnlineViewController.m
//  MyDouYu
//
//  Created by Hubin_Huang on 16/6/25.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "OnlineViewController.h"
#import "OnlineCollectionCell.h"



@interface OnlineViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *onlineCollection;

@property (nonatomic, strong) NSArray * titleArr;
@property (nonatomic, strong) NSArray * imgArr;
@property (nonatomic, strong) NSArray * nickArr;

@end

@implementation OnlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self requestData];
    
    [self initCollectionView];
}

- (void)requestData
{
    //网络请求
    
    //假数据
    self.titleArr = @[@"狂拽吊炸天",@"狂拽吊炸天",@"狂拽吊炸天",@"狂拽吊炸天",@"狂拽吊炸天",@"狂拽吊炸天",@"狂拽吊炸天"];
    self.imgArr = @[@"Image_about",@"Image_about",@"Image_about",@"Image_about",@"Image_about",@"Image_about",@"Image_about",];

    self.nickArr = @[@"还有谁???",@"还有谁???",@"还有谁???",@"还有谁???",@"还有谁???",@"还有谁???",@"还有谁???"];
    
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
    
    flowLayout.itemSize = CGSizeMake(itemSize, itemSize/(220/120));
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
    return self.titleArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OnlineCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"onlineCell" forIndexPath:indexPath];
    [cell layoutCollectionCell];
    
    cell.titleImageView.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
    cell.roomTitleLabel.text = self.titleArr[indexPath.row];
    cell.nicknameLabel.text = @"这不科学!!!";

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
