//
//  RYNewsTableViewCell.m
//  网易彩票
//
//  Created by 宋占波 on 16/7/21.
//  Copyright © 2016年 HeiMaChengXuYuan. All rights reserved.
//

#import "RYNewsTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface RYNewsTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImageView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLab;
@property (weak, nonatomic) IBOutlet UILabel *sourceLab;
@property (weak, nonatomic) IBOutlet UILabel *replyLab;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgsrcImageViews;

@end

@implementation RYNewsTableViewCell

- (void)setModel:(RYNewsModel *)model{
    
    _model = model;
    [self.imgsrcImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.TitleLab.text = model.title;
    self.sourceLab.text = model.source;
    self.replyLab.text = [NSString stringWithFormat:@"%@",model.replyCount];
    
    for (int i = 0; i < model.imgextra.count; i++) {
        //取出控件
        UIImageView *img = self.imgsrcImageViews[i];
        
        NSDictionary *dic = model.imgextra[i];
        
        NSString *imgsrc = [dic objectForKey:@"imgsrc"];
        
        [img sd_setImageWithURL:[NSURL URLWithString:imgsrc]];
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
