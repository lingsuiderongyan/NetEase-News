//
//  RYCycleCollectionViewCell.m
//  网易彩票
//
//  Created by 宋占波 on 16/7/21.
//  Copyright © 2016年 HeiMaChengXuYuan. All rights reserved.
//

#import "RYCycleCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface RYCycleCollectionViewCell ( )
@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation RYCycleCollectionViewCell

- (void)setModel:(RYCycleModel *)model{
    _model = model;
    //轮播图图片
    [self.imgsrcImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    //轮播图title
    self.titleLab.text = model.title;
}

@end
