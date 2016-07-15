//
//  ColumnCell.m
//  MyDouYu
//
//  Created by Mac on 16/7/15.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "ColumnCell.h"

@implementation ColumnCell

-(void)setcolumnData:(ColumnModel *)columnModel
{
    WS(ws);
    UIImageView *imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(ws).with.insets(UIEdgeInsetsMake(0, 0, 20 *K5SWScale, 0));
    }];
    
    UILabel *label = [[UILabel alloc]init];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(imageView.mas_top);
        make.left.equalTo(ws.mas_left);
        make.right.equalTo(ws.mas_right);
        make.bottom.equalTo(ws.mas_bottom);
    }];
}

@end
