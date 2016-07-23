//
//  RYNewsModel.m
//  网易彩票
//
//  Created by 宋占波 on 16/7/19.
//  Copyright © 2016年 HeiMaChengXuYuan. All rights reserved.
//

#import "RYNewsModel.h"
#import "RYNetworlTools.h"

@implementation RYNewsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+ (instancetype)NewsModelWithDic:(NSDictionary *)dic{
    
    RYNewsModel *model = [[RYNewsModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
    
}

//下载
+ (void)downloadWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *arr))successBlock failureBlock:(void(^)(NSError *error))failureBlock{
    
    //NSLog(@"------%@",urlstr);
    [[RYNetworlTools sharedNetworlTool]GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject;
        NSString *key = dic.keyEnumerator.nextObject;
        //NSLog(@"key%@",key);
        NSArray *arr = [dic objectForKey:key];
        
        //可变的数组
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        
        //遍历arr
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            RYNewsModel *model = [self NewsModelWithDic:obj];
            [arrM addObject:model];
        }];
        if (successBlock) {
            successBlock(arrM.copy);
        }
        //NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
        
    }];

}

@end
