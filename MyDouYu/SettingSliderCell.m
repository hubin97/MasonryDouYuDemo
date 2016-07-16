//
//  SettingSliderCell.m
//  MyDouYu
//
//  Created by Hubin_Huang on 16/7/16.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "SettingSliderCell.h"

@implementation SettingSliderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    WS(ws);
    
    self.smallImgView = [[UIImageView alloc]init];
    [self addSubview:self.smallImgView];
    
    self.setSlider = [[UISlider alloc]init];
    [self addSubview:self.setSlider];
    
    self.bigImgView = [[UIImageView alloc]init];
    [self addSubview:self.bigImgView];
    
    [self.smallImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(ws.mas_left).offset(10 *K5SWScale);
        make.width.equalTo(self.smallImgView.mas_height);

        make.centerY.equalTo(ws);

    }];
    
    [self.bigImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(ws.mas_right).offset(-10 *K5SWScale);
        make.width.equalTo(self.bigImgView.mas_height);
        make.centerY.equalTo(ws);
    }];
    
    [self.setSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(ws.smallImgView.mas_right).offset(5 *K5SWScale);
        make.right.equalTo(ws.bigImgView.mas_left).offset(-5 * K5SWScale);
        make.centerY.equalTo(ws);
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
