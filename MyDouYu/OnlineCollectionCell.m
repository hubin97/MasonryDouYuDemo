//
//  OnlineCollectionViewCell.m
//  MyDouYu
//
//  Created by Hubin_Huang on 16/6/26.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "OnlineCollectionCell.h"

@interface OnlineCollectionCell()

@property (nonatomic, strong) UIImageView *titleImageView; //图
@property (nonatomic, strong) UIView  *backgroudView; //文字背景框
@property (nonatomic, strong) UILabel *nicknameLabel; //主播名字
@property (nonatomic, strong) UILabel *onlinePeopleLabel;  //人气
@property (nonatomic, strong) UILabel *roomTitleLabel;   //房间标题
@end


@implementation OnlineCollectionCell


- (void)setOnlineData:(OnlineModel *)onlineModel
{
    
    //Masonry lay out
    WS(ws);
    
#warning -----使用Masonry布局前务必对视图初始化
    self.titleImageView = [[UIImageView alloc]init];
    
    [self addSubview:self.titleImageView];
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView).with.insets(UIEdgeInsetsMake(0, 0, 20 *K5SWScale, 0));
        //make.centerXWithinMargins.equalTo(ws); //x居中
        //设置宽高比例 // width / height  == 220 / 100
        make.height.mas_equalTo(ws.titleImageView.mas_width).multipliedBy(2);
    }];
    
    NSLog(@"self.contentView= %@",self.contentView);

    NSLog(@"self.titleImageView= %@",self.titleImageView);
    
    self.roomTitleLabel = [[UILabel alloc]init];

    //DrawBorderForView(self.roomTitleLabel, 2, brownColor);

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
    //DrawBorderForView(self.nicknameLabel, 2, blueColor);

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
    //DrawBorderForView(onlineImgView, 2, redColor);

    [self.backgroudView addSubview:onlineImgView];
    [onlineImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroudView.mas_top);
        make.left.equalTo(self.nicknameLabel.mas_right);
        make.bottom.equalTo(self.backgroudView.mas_bottom);
        make.width.mas_equalTo(userImgView.mas_width);
        make.height.mas_equalTo(onlineImgView.mas_width);
    }];
    
    self.onlinePeopleLabel = [[UILabel alloc]init];
    
    //DrawBorderForView(self.onlinePeopleLabel, 2, greenColor);

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
    
    //init
    //[self.titleImageView sd_setImageWithURL:[NSURL URLWithString:[onlineModel.room_src stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"Image_no_data"]];

    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:onlineModel.room_src] placeholderImage:[UIImage imageNamed:@"Image_no_data"]];
    self.nicknameLabel.text = onlineModel.nickname;
    self.nicknameLabel.font = [UIFont systemFontOfSize:10.0f *K5SWScale];
    self.nicknameLabel.textColor = [UIColor whiteColor];
    
    self.onlinePeopleLabel.text = ([onlineModel.online intValue] > 9999)?[NSString stringWithFormat:@"%0.1f万",[onlineModel.online doubleValue]/10000]: onlineModel.online;

    self.onlinePeopleLabel.font = [UIFont systemFontOfSize:10.0f *K5SWScale];
    self.onlinePeopleLabel.textColor = [UIColor whiteColor];

    self.roomTitleLabel.text = onlineModel.room_name;
    self.roomTitleLabel.font = [UIFont systemFontOfSize:13.0f *K5SWScale];

}

#warning 解决复用时沿用上一个Cell的属性
//可参考:http://blog.csdn.net/godblessmyparents/article/details/50675263
//疑问? 此处单个label为何会重叠? 使用此方法会影响复用机制?
/**
 - (void)prepareForReuse;
 
 当被重用的cell将要显示时，会调用这个方法，这个方法最大的用武之地是当你自定义的cell上面有图片时，如果产生了重用，图片可能会错乱（当图片来自异步下载时及其明显），这时我们可以重写这个方法把内容抹掉。
 */
- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.roomTitleLabel.text = nil;
}
@end
