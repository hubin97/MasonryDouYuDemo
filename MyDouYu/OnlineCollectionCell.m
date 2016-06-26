//
//  OnlineCollectionViewCell.m
//  MyDouYu
//
//  Created by Hubin_Huang on 16/6/26.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "OnlineCollectionCell.h"

@implementation OnlineCollectionCell


- (void)layoutCollectionCell
{
    WS(ws);
    
#warning -----使用Masonry布局前务必对视图初始化
    self.titleImageView = [[UIImageView alloc]init];
    
    [self addSubview:self.titleImageView];
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView).with.insets(UIEdgeInsetsMake(0, 0, 20 *K5SWScale, 0));
        //make.centerXWithinMargins.equalTo(ws); //x居中
        //设置宽高比例 // width / height  == 220 / 100
        make.height.mas_equalTo(ws.titleImageView.mas_width).multipliedBy(2.2);
    }];
    
    NSLog(@"self.contentView= %@",self.contentView);

    NSLog(@"self.titleImageView= %@",self.titleImageView);
    
    self.roomTitleLabel = [[UILabel alloc]init];

    DrawBorderForView(self.roomTitleLabel, 2, brownColor);

    [self addSubview:self.roomTitleLabel];
    [self.roomTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.mas_left);
        make.bottom.equalTo(ws.mas_bottom);
        make.right.equalTo(ws.mas_right);
        make.height.mas_equalTo(20*K5SWScale);
    }];
    
    self.backgroudView = [[UIView alloc]init];
    //DrawBorderForView(self.backgroudView, 2, redColor);

    [self.titleImageView addSubview:self.backgroudView];
    [self.backgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.titleImageView.mas_left);
        make.bottom.equalTo(ws.titleImageView.mas_bottom);
        make.right.equalTo(ws.titleImageView.mas_right);
        make.height.mas_equalTo(20*K5SWScale);
    }];
    
    //bg布局
    UIImageView *userImgView = [[UIImageView alloc]init];
    userImgView.image = [UIImage imageNamed:@"Img_user.png"];
    
    //DrawBorderForView(userImgView, 2, redColor);

    [self.backgroudView addSubview:userImgView];
    [userImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.backgroudView.mas_top);
        make.left.equalTo(ws.backgroudView.mas_left);
        make.bottom.equalTo(ws.backgroudView.mas_bottom);
        make.height.mas_equalTo(userImgView.mas_width);//.multipliedBy(1);
    }];
    
    //
    self.nicknameLabel = [[UILabel alloc]init];
    DrawBorderForView(self.nicknameLabel, 2, blueColor);

    [self.backgroudView addSubview:self.nicknameLabel];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroudView.mas_top);
        make.left.equalTo(userImgView.mas_right);
        make.bottom.equalTo(self.backgroudView.mas_bottom);
        //此句可以注释,取得剩余的宽度
        //make.width.mas_equalTo(self.nicknameLabel.mas_height).multipliedBy(4);
    }];
    
    
    UIImageView *onlineImgView = [[UIImageView alloc]init];
    onlineImgView.image = [UIImage imageNamed:@"Image_online.png"];
    DrawBorderForView(onlineImgView, 2, redColor);

    [self.backgroudView addSubview:onlineImgView];
    [onlineImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroudView.mas_top);
        make.left.equalTo(self.nicknameLabel.mas_right);
        make.bottom.equalTo(self.backgroudView.mas_bottom);
        make.width.mas_equalTo(userImgView.mas_width);
        make.height.mas_equalTo(onlineImgView.mas_width);
    }];
    
    self.onlinePeopleLabel = [[UILabel alloc]init];
    
    DrawBorderForView(self.onlinePeopleLabel, 2, greenColor);

    [self.backgroudView addSubview:self.onlinePeopleLabel];
    [self.onlinePeopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroudView.mas_top);
        make.left.equalTo(onlineImgView.mas_right);
        make.bottom.equalTo(self.backgroudView.mas_bottom);
        make.right.equalTo(self.backgroudView.mas_right);
        make.height.mas_equalTo(self.backgroudView.mas_height);
        make.width.mas_equalTo(self.onlinePeopleLabel.mas_height).multipliedBy(2);
    }];

    NSLog(@"self.backgroudView = %@",self.backgroudView);
}
@end
