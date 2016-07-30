//
//  ColumnModel.h
//  MyDouYu
//
//  Created by Mac on 16/7/15.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColumnModel : NSObject
/**
 "cate_id" = 201;
 "game_icon" = "http://staticlive.douyucdn.cn/upload/game_cate/85bc857edb57043379d94461e5a538ee.jpg";
 "game_name" = "\U989c\U503c";
 "game_src" = "http://staticlive.douyucdn.cn/upload/game_cate/e0dc90c25498c2702b42b20b4b0dc61a.jpg";
 "game_url" = "/directory/game/yz";
 "online_room" = 190;
 "online_room_ios" = 190;
 "short_name" = yz;
 */
@property (nonatomic, strong) NSString *cate_id;
@property (nonatomic, strong) NSString *game_icon;
@property (nonatomic, strong) NSString *game_name;
@property (nonatomic, strong) NSString *game_src;
@property (nonatomic, strong) NSString *game_url;
@property (nonatomic, strong) NSString *online_room;
@property (nonatomic, strong) NSString *online_room_ios;
@property (nonatomic, strong) NSString *short_name;

@end
