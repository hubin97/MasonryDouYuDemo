//
//  MJToast.h
//  Common
//
//  Created by 黄磊 on 16/4/6.
//  Copyright © 2016年 Musjoy. All rights reserved.
//  Toast

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MJToast : NSObject 

/**
 *	@brief	弹出MJToast方法。
 */
- (void)show;

/**
 *	@brief	构造一个MJToast对象
 *
 *	@param 	text 	需要显示的字符串
 *
 *	@return	返回的MJToast对象
 */
+ (MJToast *)makeToast:(NSString *)text;

@end
