//
//  SettingSwitchCell.m
//  MyDouYu
//
//  Created by Hubin_Huang on 16/7/16.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "SettingSwitchCell.h"

@implementation SettingSwitchCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    WS(ws);
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(ws.mas_left).offset(10 * K5SWScale);
        make.width.mas_equalTo(ws.mas_width).multipliedBy(0.5);
        make.centerY.equalTo(ws);
    }];
    
    self.switchBtn = [[UISwitch alloc]initWithFrame:CGRectZero];
    [self addSubview:self.switchBtn];
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(ws.mas_right).offset(-10 * K5SWScale);
        make.centerY.equalTo(ws);
    }];
    
    self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    
    self.switchBtn.onTintColor = COLOR(248, 97, 34, 1);
    self.switchBtn.on = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

@end
