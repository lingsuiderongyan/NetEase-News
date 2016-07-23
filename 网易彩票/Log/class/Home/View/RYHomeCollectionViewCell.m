//
//  RYHomeCollectionViewCell.m
//  网易彩票
//
//  Created by 宋占波 on 16/7/19.
//  Copyright © 2016年 HeiMaChengXuYuan. All rights reserved.
//

#import "RYHomeCollectionViewCell.h"
#import "RYNewsTableViewController.h"

@interface RYHomeCollectionViewCell ()

@property (strong, nonatomic) RYNewsTableViewController *newsVC;

@end

@implementation RYHomeCollectionViewCell

- (void)awakeFromNib{
//    self.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    UIStoryboard *Storyboard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    
    self.newsVC = [Storyboard instantiateInitialViewController];
    self.newsVC.tableView.frame = self.contentView.bounds;
    self.newsVC.tableView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    [self addSubview:self.newsVC.tableView];
}

- (void)setUrlstr:(NSString *)urlstr{

    _urlstr = urlstr;
    self.newsVC.urlstr = urlstr;
    
}

@end














