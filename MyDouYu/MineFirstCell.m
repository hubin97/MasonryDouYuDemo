//
//  MineFirstCell.m
//  MyDouYu
//
//  Created by Hubin_Huang on 16/6/25.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "MineFirstCell.h"

@implementation MineFirstCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    WS(ws);
    
    //头像框
    self.headerImageView = [[UIImageView alloc]init];

    [self addSubview:self.headerImageView];
    
    CGFloat padding = 5 * K5SWScale;
    CGFloat headerSizeH = 65 * K5SWScale;
    
    self.headerImageView.layer.cornerRadius = headerSizeH/2;
    self.headerImageView.layer.masksToBounds = YES;
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //make.edges.equalTo(ws).insets(UIEdgeInsetsMake(padding, 2 * padding, padding, self.frame.size.width - self.frame.size.height -  6 * padding ));
        
        make.top.equalTo(ws.mas_top).with.offset(padding);
        make.left.equalTo(ws.mas_left).with.offset(2 *padding);
        make.bottom.equalTo(ws.mas_bottom).with.offset(- padding);
        
        make.width.mas_equalTo(headerSizeH);
        make.height.mas_equalTo(headerSizeH);
    }];
   
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
