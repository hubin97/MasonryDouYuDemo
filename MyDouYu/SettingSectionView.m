//
//  SettingHeaderView.m
//  MyDouYu
//
//  Created by Hubin_Huang on 16/7/9.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "SettingSectionView.h"

@implementation SettingSectionView
//@synthesize titleLabel;
//@synthesize flodButton;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}

-(instancetype)init
{
    WS(ws);
    
    if (self = [super init])
    {
        self.titleLabel = [[UILabel alloc]init];
        self.flodButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws).insets(UIEdgeInsetsMake(5*K5SWScale, 20*K5SWScale, 5*K5SWScale, (ws.frame.size.width - 10 *K5SWScale)/2));
            make.centerY.equalTo(ws);
        }];

        [self addSubview:self.flodButton];
        [self.flodButton mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.edges.equalTo(ws).insets(UIEdgeInsetsMake(5*K5SWScale, ws.frame.size.width - 40 *K5SWScale, 5*K5SWScale, 20*K5SWScale));
            
            make.right.equalTo(self.mas_right).offset(- 5* K5SWScale);
            
            make.width.mas_equalTo(self.flodButton.mas_height);
            make.centerY.equalTo(ws);
        }];
        
        //Image_arrow_right
        //Image_arrow_down
//        [self.flodButton setImage:[UIImage imageNamed:@"Image_arrow_down"] forState:UIControlStateNormal];
//        [self.flodButton setImage:[UIImage imageNamed:@"Image_arrow_right"] forState:UIControlStateSelected];
        
//        [self.flodButton addTarget:self action:@selector(flodBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return self;
    }
    return self;
}

- (void)flodBtnClick:(UIButton *)sender
{
    
//    if (sender.selected)
//    {
//        NSLog(@"Image_arrow_right");
//        [self.flodButton setImage:[UIImage imageNamed:@"Image_arrow_right"] forState:UIControlStateNormal];
//    }
//    else
//    {
//        NSLog(@"Image_arrow_down");
//        [self.flodButton setImage:[UIImage imageNamed:@"Image_arrow_down"] forState:UIControlStateNormal];
//    }
//    self.flodButton.selected = !sender.selected;

}

@end
