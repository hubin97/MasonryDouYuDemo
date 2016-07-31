//
//  NewShowModel.h
//  MyDouYu
//
//  Created by Hubin_Huang on 16/7/30.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewShowModel : NSObject

@property(nonatomic,strong)NSString *nickname; //昵称

@property(nonatomic,strong)NSString *game_name; //游戏类名

@property(nonatomic,strong)NSString *game_url;

@property(nonatomic,strong)NSString *owner_uid;

@property(nonatomic,strong)NSString *url;

@property(nonatomic,strong)NSString *vod_quality;

@property(nonatomic,strong)NSString *specific_status;

@property(nonatomic,strong)NSString *specific_catalog;

@property(nonatomic,strong)NSString *show_status;

@property(nonatomic,strong)NSString *show_time;

@property(nonatomic,strong)NSString *room_name;

@property(nonatomic,strong)NSString *cate_id;

@property(nonatomic,strong)NSString *room_src;

@property(nonatomic,strong)NSString *room_id;


@end
