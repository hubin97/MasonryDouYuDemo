//
//  ColumnCell.m
//  MyDouYu
//
//  Created by Mac on 16/7/15.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "ColumnCell.h"

@implementation ColumnCell
{
    UILabel *gamesLabel;
}

-(void)setcolumnData:(ColumnModel *)columnModel
{
    WS(ws);
    UIImageView *imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(ws).with.insets(UIEdgeInsetsMake(0, 0, 30 *K5SWScale, 0));
    }];
    [imageView sd_setImageWithURL:[NSURL URLWithString:columnModel.game_icon] placeholderImage:[UIImage imageNamed:@"Image_no_data"]];
    
    gamesLabel = [[UILabel alloc]init];
    [self addSubview:gamesLabel];
    [gamesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(imageView.mas_bottom);
        make.left.equalTo(ws.mas_left);
        make.right.equalTo(ws.mas_right);
        make.bottom.equalTo(ws.mas_bottom);
    }];
    gamesLabel.text = columnModel.game_name;
    gamesLabel.textAlignment = NSTextAlignmentCenter;
    //[gamesLabel sizeToFit];  // 没有效果??
    gamesLabel.font = [UIFont systemFontOfSize:15];
    
    
    UILabel*lineLabel = [[UILabel alloc]init];
    [self addSubview:lineLabel];
    lineLabel.backgroundColor = [UIColor redColor];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(gamesLabel.mas_left);
        make.right.equalTo(gamesLabel.mas_right);
        make.bottom.equalTo(gamesLabel.mas_bottom);
        make.height.mas_equalTo(2);
        
    }];
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    gamesLabel.text = nil;
}
@end
