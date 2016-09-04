//
//  RecommendHeadView.m
//  MyDouYu
//
//  Created by Hubin_Huang on 16/8/29.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "RecommendHeadView.h"

@implementation RecommendHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        WS(ws);
        
        CGFloat padding = 5 * K5SWScale;
        //左,红色标记
        UIImageView *redflag = [[UIImageView alloc]init];
        [self addSubview:redflag];
        [redflag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ws.mas_left).offset(padding);
            make.top.mas_equalTo(ws.mas_top);
            make.bottom.mas_equalTo(ws.mas_bottom);
            make.width.mas_equalTo(@(padding));
        }];
        
        //右,
        UIImageView *rightflag = [[UIImageView alloc]init];
        [self addSubview:rightflag];
        [rightflag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(ws.mas_right).offset(- padding);
            make.top.mas_equalTo(ws.mas_top).offset(padding);
            make.bottom.mas_equalTo(ws.mas_bottom).offset( - padding);
            make.width.mas_equalTo(rightflag.mas_height);
        }];
        UILabel *moreLabel = [[UILabel alloc]init];
        [self addSubview:moreLabel];
        [moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(rightflag.mas_left).offset(- padding);
            make.top.mas_equalTo(ws.mas_top);
            make.bottom.mas_equalTo(ws.mas_bottom);
            make.width.mas_equalTo(moreLabel.mas_height).multipliedBy(1.2);
        }];
        //DrawBorderForView(moreLabel, 2, yellowColor);

        
        //中间,title
        self.sectionTitleLabel = [[UILabel alloc]init];
        [self addSubview:self.sectionTitleLabel];
        [self.sectionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(redflag.mas_right).offset(2 *padding);
            make.top.mas_equalTo(ws.mas_top);
            make.bottom.mas_equalTo(ws.mas_bottom);
            make.right.mas_equalTo(moreLabel.mas_left);
        }];
        //DrawBorderForView(self.sectionTitleLabel, 2, redColor);
        
        redflag.backgroundColor = [UIColor redColor];
        redflag.layer.masksToBounds = YES;
        redflag.layer.cornerRadius = 10;
        
        rightflag.hidden = self.isHiddenRightView;
        moreLabel.hidden = self.isHiddenRightView;
        rightflag.image  = [UIImage imageNamed:@"btn_more"];
        moreLabel.text = @"更多";
        moreLabel.textColor = [UIColor redColor];
        
        return self;
    }
    return self;
}





@end
