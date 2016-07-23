//
//  RYCycleCollectionViewController.m
//  RYCycleCollectionViewCell
//  网易彩票
//
//  Created by 宋占波 on 16/7/21.
//  Copyright © 2016年 HeiMaChengXuYuan. All rights reserved.
//

#import "RYCycleCollectionViewController.h"
#import "RYCycleModel.h"
#import "RYCycleCollectionViewCell.h"

@interface RYCycleCollectionViewController ()

//接收数据用
@property (strong, nonatomic) NSArray *dataArr;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *FlowLayout;

@property (strong, nonatomic) UIPageControl *pageControl;
@end

@implementation RYCycleCollectionViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //设置cell的大小
    self.FlowLayout.itemSize = self.collectionView.bounds.size;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createPageControl];
    
    [self loadCycleModelData];
}

//创建PageControl
- (void)createPageControl{
    self.pageControl = [[UIPageControl alloc]init];
    [self.view addSubview:self.pageControl];
    
    //设置选中的颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    //设置未选中的颜色
    self.pageControl.pageIndicatorTintColor = [UIColor blackColor];
}

//下载数据
- (void)loadCycleModelData{
    
    [RYCycleModel loadCycleDataWithUrlstr:@"ad/headline/0-4.html" successBlock:^(NSArray *listArr) {
        
        self.dataArr = listArr;
        //刷新ui
        [self.collectionView reloadData];
        
        //设置pagecontrol
        //设置个数
        self.pageControl.numberOfPages = self.dataArr.count;
        
        //获取pageControl的size
        CGSize pageControlSize = [self.pageControl sizeForNumberOfPages:self.dataArr.count];
        //pageControl的frame
        CGFloat pageControlX = self.view.bounds.size.width - pageControlSize.width - 10;
        CGFloat pageControlY = self.view.bounds.size.height - pageControlSize.height;
        self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlSize.width, pageControlSize.height);
        
        //刷完collectionView之后,把item滚动到第四个
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.dataArr.count inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:YES];
        
    } failBlock:^(NSError *error) {
        NSLog(@"error---->%@",error);
    }];
    
}

//滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //计算当前在第几个item
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    
    //设置pageControl跟着滚动
    self.pageControl.currentPage = index%self.dataArr.count;
    
    //准备索引
    NSIndexPath *indexPath;
    
    //重新获取item的总个数
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    //滚动到最前面
    if (index == 0) {
        indexPath = [NSIndexPath indexPathForItem:self.dataArr.count inSection:0];
    }else if (index == items - 1){
        //滚动到最后面的情况
        indexPath = [NSIndexPath indexPathForItem:self.dataArr.count - 1 inSection:0];
    }
    //滚动collectionView
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
}

//

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArr.count * 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RYCycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CycleCell"forIndexPath:indexPath];

    //cell.backgroundColor = [UIColor redColor];
    //获取model
    RYCycleModel *model = self.dataArr[indexPath.item%self.dataArr.count];
    cell.model = model;
    
    return cell;
}


@end







