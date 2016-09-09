//
//  RecommendCell.h
//  MyDouYu
//
//  Created by liyonghu on 16/9/7.
//  Copyright © 2016年 TUTK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChanelData.h"

@interface RecommendCell : UITableViewCell<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

- (void)setContentViewWithModelArrs:(NSArray *)channelDataArrs;

@end
