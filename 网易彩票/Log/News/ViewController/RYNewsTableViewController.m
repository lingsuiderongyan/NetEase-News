//
//  RYNewsTableViewController.m
//  网易彩票
//
//  Created by 宋占波 on 16/7/19.
//  Copyright © 2016年 HeiMaChengXuYuan. All rights reserved.
//

#import "RYNewsTableViewController.h"
#import "RYNewsModel.h"
#include "RYNewsTableViewCell.h"

@interface RYNewsTableViewController ()

@property (strong, nonatomic) NSArray *dataArr;

@end

@implementation RYNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)setUrlstr:(NSString *)urlstr
{
    NSLog(@"%@",urlstr);
    
    [RYNewsModel downloadWithUrlstr:urlstr successBlock:^(NSArray *arr) {
        //        NSLog(@"arr  %@",arr);
        
        //给dataArr 赋值
        self.dataArr = arr;
        //刷新表格
        [self.tableView reloadData];
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"error %@",error);
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RYNewsModel *model = self.dataArr[indexPath.row];
    //判断是否是大图
    NSString *Identifier;
    if (model.imgType) {
        Identifier = @"bigCell";
    }else if (model.imgextra.count == 2){
        Identifier = @"ImagesCell";
    }else{
        Identifier = @"BaseCell";
    }
    
    RYNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    //cell.textLabel.text = model.title;
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RYNewsModel *model = self.dataArr[indexPath.row];
    if (model.imgType) {
        //大图的宽
        return 250;
    }else if (model.imgextra.count == 2){
        //多图的宽度
        return 150;
    }else{
        //小图的宽度
        return 80;
    }
}


@end
