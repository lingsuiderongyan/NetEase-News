//
//  RYNetworlTools.m
//  网易彩票
//
//  Created by 宋占波 on 16/7/19.
//  Copyright © 2016年 HeiMaChengXuYuan. All rights reserved.
//  http://c.m.163.com/nc/T1348647853363

#import "RYNetworlTools.h"
#import "AFNetworking.h"

@implementation RYNetworlTools

static id _instancetype;
+(instancetype)sharedNetworlTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *baseurl = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        _instancetype = [[self alloc]initWithBaseURL:baseurl];
    });
    return _instancetype;
}

@end
