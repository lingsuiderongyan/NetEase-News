//
//  RYCycleModel.h
//  网易彩票
//
//  Created by 宋占波 on 16/7/21.
//  Copyright © 2016年 HeiMaChengXuYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RYCycleModel : NSObject

//轮播图标题
@property (copy, nonatomic) NSString *title;

//轮播图片
@property (copy, nonatomic) NSString *imgsrc;

//下载方法
+(void)loadCycleDataWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *listArr))successBlock failBlock:(void (^)(NSError *error))failBlock;

@end
