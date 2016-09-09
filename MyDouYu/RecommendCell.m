//
//  RecommendCell.m
//  MyDouYu
//
//  Created by liyonghu on 16/9/7.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "RecommendCell.h"

#import "OnlineCollectionCell.h"  //样式与此部分一致

@interface RecommendCell()
{
    UICollectionView *_myCollection;
    NSMutableArray *_dateSourceArray;
}
@end

@implementation RecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContentViewWithModelArrs:(NSArray *)channelDataArrs
{
    WS(ws);
    
    NSLog(@"channelDataArrs:%@",channelDataArrs);
    
    for (ChanelData *model in channelDataArrs) {
        
        NSLog(@"channelDataArrs/room_name:%@",model.room_name);
        NSLog(@"channelDataArrs/nickname:%@",model.nickname);
    }
    
    _dateSourceArray = [NSMutableArray arrayWithArray:channelDataArrs];
    
    
    CGFloat padding = 10;
    int col = 2;
    CGFloat itemSizeW = ([UIScreen mainScreen].bounds.size.width - (col + 1) * padding)/col;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.sectionInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    layout.itemSize = CGSizeMake(itemSizeW, itemSizeW/1.5);
    layout.minimumLineSpacing = padding;
    layout.minimumInteritemSpacing = padding;
    
    _myCollection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _myCollection.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_myCollection];
    
    [_myCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(ws);
    }];
    
    _myCollection.dataSource = self;
    _myCollection.delegate = self;
    
    //此处当做cell用禁掉滑动
    _myCollection.showsVerticalScrollIndicator = NO;
    _myCollection.showsHorizontalScrollIndicator = NO;
    _myCollection.scrollEnabled = NO;
    
    [_myCollection registerClass:[OnlineCollectionCell class] forCellWithReuseIdentifier:@"onlineCell"];

    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"onlineCell";
    
    //OnlineCollectionCell内使用model可以通用
    OnlineCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    [cell setOnlineData:_dateSourceArray[indexPath.item]];
    
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 5.0f;
    
    DrawBorderForView(cell, 1, brownColor);
    
    return cell;
}
@end
