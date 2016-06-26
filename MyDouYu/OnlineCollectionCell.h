//
//  OnlineCollectionViewCell.h
//  MyDouYu
//
//  Created by Hubin_Huang on 16/6/26.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnlineCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *titleImageView; //图
@property (nonatomic, strong) UIView  *backgroudView; //文字背景框
@property (nonatomic, strong) UILabel *nicknameLabel; //主播名字
@property (nonatomic, strong) UILabel *onlinePeopleLabel;  //人气
@property (nonatomic, strong) UILabel *roomTitleLabel;   //房间标题

- (void)layoutCollectionCell;

@end
