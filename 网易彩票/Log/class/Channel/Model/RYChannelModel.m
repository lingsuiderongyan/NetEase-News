//
//  RYChannelModel.m
//  网易彩票
//
//  Created by 宋占波 on 16/7/19.
//  Copyright © 2016年 HeiMaChengXuYuan. All rights reserved.
//  topic_news     topic_news.json

#import "RYChannelModel.h"

@implementation RYChannelModel

- (NSString *)description{
    return [NSString stringWithFormat:@"%@--%@",_tid,_tname];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //此方法是调用没有声明的KEY,无需任何操作,无此方法,往里存东西的时候发现没有这个KEY,KEY不能为空
}

+ (instancetype)channelWithDic:(NSDictionary *)dic{
    RYChannelModel *model = [[RYChannelModel alloc]init];
    //kvc
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
}

+ (NSArray *)channels{
    
    //获取json文件
    NSString *path = [[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    //转成二进制
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    //反序列化
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //取出tList对应数组
    NSArray *arr = [dic objectForKey:@"tList"];
    
    //可变数组
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
    //便利数组
    [arr enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //获取model
        RYChannelModel *model = [self channelWithDic:obj];
        
        //把model添加到可变数组
        [arrM addObject:model];
    }];
    //key排序
    [arrM sortUsingComparator:^NSComparisonResult(RYChannelModel * obj1, RYChannelModel * obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    
    return arrM.copy;
}

@end
