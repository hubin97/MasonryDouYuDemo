//
//  NewShowCell.m
//  MyDouYu
//
//  Created by Hubin_Huang on 16/7/30.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import "NewShowCell.h"

@implementation NewShowCell

//-(void)setContentView:(NSArray *)array
//{
//    for (int i=0; i<array.count; i++) {
//        NewShowData *newData=array[i];
//        
//        CGRect frame=CGRectMake((i+1)*5+i*90, 5, 90, 135);
//        NewShow *_newShowView=[[NewShow alloc]init];
//        _newShowView.tag=i;
//        _newShowView.frame=frame;
//        
//        [_newShowView.HeadView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",NEW_Image_URl,[self countNumAndChangeformat:newData.owner_uid],NEW_Time_URl,[NSString GetNowTimes]]] placeholderImage:[UIImage imageNamed:@"Img_default"]];
//        
//        _newShowView.Name.text=newData.nickname;
//        _newShowView.Game.text=newData.game_name;
//        
//        [_backScrollView addSubview:_newShowView];
//        
//        UITapGestureRecognizer *tapNewview=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOneNewView:)];
//        [_newShowView addGestureRecognizer:tapNewview];
//        
//    }
//    
//    _backScrollView.contentSize=CGSizeMake(10*95, 0);
//}
@end
