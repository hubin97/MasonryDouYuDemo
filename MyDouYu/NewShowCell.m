//
//  NewShowCell.m
//  MyDouYu
//
//  Created by Hubin_Huang on 16/7/30.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "NewShowCell.h"
#define cellHeight 180

@implementation NewShowCell
{
    UILabel *gamesLabel;
}
- (void)setContentViewWithArrays:(NSArray *)newShowArr
{
    WS(ws);
    
    //移除旧视图,避免反复加载出现问题
    
    for (UIView *tmpView in self.subviews)
    {
        [tmpView removeFromSuperview];
    }
    
    
    //NSLog(@"newShowArr:%@",newShowArr);
    
//    for (NewShowModel *model in newShowArr)
//    {
//        NSLog(@"game_url;%@",model.game_url);
//    }
    
    UIScrollView *newShowScrol = [[UIScrollView alloc]init];
    [self addSubview:newShowScrol];
    newShowScrol.showsVerticalScrollIndicator = NO;
    newShowScrol.alwaysBounceVertical = NO;
    
    
    CGFloat padding = 10;
    CGFloat cellViewScal = 1.5;
    
    UIView *lastCellView = nil; //用于获取前一个cellView的位置
    
    for (NewShowModel *newShowModel in newShowArr)
    {
        UIView *cellView = [[UIView alloc]init];
        [newShowScrol addSubview:cellView];
        
        //cellview
        //DrawBorderForView(cellView, 1.0, lightGrayColor);
        
        //单个cell
        [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(ws.mas_top).offset(padding);
            make.bottom.mas_equalTo(ws.mas_bottom).offset(-padding);

#warning 问题出在哪里? 无法设置宽高比?
            make.height.mas_equalTo(cellView.mas_width).multipliedBy(cellViewScal);
            
            //make.width.mas_equalTo(cellView.mas_height).multipliedBy(1/cellViewScal);

            
            if (lastCellView)
            {
                make.left.mas_equalTo(lastCellView.mas_right).offset(padding);
            }
            else //第一个view
            {
                make.left.mas_equalTo(newShowScrol.mas_left).offset(padding);
            }
            
        }];
        
        lastCellView = cellView;
        
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [cellView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(cellView.mas_top).offset(padding);
            make.left.mas_equalTo(cellView.mas_left).offset(padding);
            make.right.mas_equalTo(cellView.mas_right).offset(- padding);
            
            make.height.mas_equalTo(imageView.mas_width);
        }];
        //[imageView sd_setImageWithURL:[NSURL URLWithString:newShowModel.game_url] placeholderImage:[UIImage imageNamed:@"Image_no_data"]];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",NEW_Image_URl,[self countNumAndChangeformat:newShowModel.owner_uid],NEW_Time_URl,[self GetNowTimes]]] placeholderImage:[UIImage imageNamed:@"Img_default"]];

        
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius  = ((cellHeight - 2 * padding)/cellViewScal * K5SWScale - 2 * padding)/2;

        //DrawBorderForView(imageView, 1.0, brownColor);

        
        gamesLabel = [[UILabel alloc]init];
        [cellView addSubview:gamesLabel];
        [gamesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(imageView.mas_bottom).offset(padding);
            make.left.equalTo(cellView.mas_left);
            make.right.equalTo(cellView.mas_right);
            make.bottom.equalTo(cellView.mas_bottom);
        }];
        gamesLabel.text = newShowModel.game_name;
        gamesLabel.textAlignment = NSTextAlignmentCenter;
        //[gamesLabel sizeToFit];  // 没有效果??
        gamesLabel.font = [UIFont systemFontOfSize:15];
        
        //DrawBorderForView(gamesLabel, 1.0, brownColor);

        UILabel*lineLabel = [[UILabel alloc]init];
        [cellView addSubview:lineLabel];
        lineLabel.backgroundColor = [UIColor redColor];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(gamesLabel.mas_left);
            make.right.equalTo(gamesLabel.mas_right);
            make.bottom.equalTo(gamesLabel.mas_bottom);
            make.height.mas_equalTo(2);
            
        }];
        
    }
    
    if (!lastCellView)  return; //请求有延时,此cell方法会走两次
    
    [newShowScrol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws);
        
        // 让scrollview的contentSize随着内容的增多而变化
        make.right.mas_equalTo(lastCellView.mas_right).offset(padding);

    }];
}

-(NSString *)countNumAndChangeformat:(NSString *)str
{
    
    NSMutableString *num=[NSMutableString stringWithString:str];
    int temp=9-(int)num.length;
    
    if (temp) {
        
        for (int i=0; i<temp; i++) {
            
            [num insertString:@"0" atIndex:0];
        }
    }
    
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    
    NSMutableString *newstring = [NSMutableString string];
    while (count > 2) {
        count -= 2;
        NSRange rang = NSMakeRange(string.length - 2, 2);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"/" atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    
    [newstring insertString:string atIndex:0];
    
    [newstring insertString:@"/" atIndex:3];
    
    [newstring insertString:@"/" atIndex:0];
    
    [newstring stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
    
    return newstring;
    
}

- (NSString *)GetNowTimes
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    return timeString;
}


@end
