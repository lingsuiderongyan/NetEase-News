//
//  RYChannelModel.h
//  网易彩票
//
//  Created by 宋占波 on 16/7/19.
//  Copyright © 2016年 HeiMaChengXuYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RYChannelModel : NSObject

//标签名
@property (copy, nonatomic) NSString *tname;
//标签ID
@property (copy, nonatomic) NSString *tid;

+(NSArray *)channels;

@end
