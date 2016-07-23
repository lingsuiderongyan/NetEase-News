//
//  RYHomeViewController.m
//  网易彩票
//
//  Created by 宋占波 on 16/7/19.
//  Copyright © 2016年 HeiMaChengXuYuan. All rights reserved.
//

#import "RYHomeViewController.h"
#import "RYChannelModel.h"
#import "RYChanneiLab.h"
#import "RYHomeCollectionViewCell.h"

@interface RYHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *ChannelScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *NewsCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *FlowLayout;

//数据接收
@property (strong, nonatomic) NSArray *dataArr;

//标签数组
@property (strong, nonatomic) NSMutableArray *labM;

@end

@implementation RYHomeViewController

- (NSMutableArray *)labM{
    if (_labM == nil) {
        _labM = [NSMutableArray array];
    }
    return _labM;
}

- (NSArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [RYChannelModel channels];
    }
    return _dataArr;
}

- (void)viewDidAppear:(BOOL)animated{
    //设置item的大小
    self.FlowLayout.itemSize = self.NewsCollectionView.bounds.size;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self creatChannelLab];
}

//MARK: - 创建频道标签
- (void)creatChannelLab{
    int LabW = 80;
    int LabH = self.ChannelScrollView.bounds.size.height;
    for (int i = 0; i < self.dataArr.count; i++) {
        RYChanneiLab * lab = [[RYChanneiLab alloc]init];
        
        //给lab设置frame
        lab.frame = CGRectMake(LabW *i, 0, LabW, LabH);
        
        //获取model
        RYChannelModel *model = self.dataArr[i];
        //给lab赋值
        lab.text = model.tname;
        
//        //设置lab的背景颜色
//        lab.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        
        //给lab设置tag
        lab.tag = i;
        
        [self.ChannelScrollView addSubview:lab];
        
        //设置横向滚动
        self.ChannelScrollView.contentSize = CGSizeMake(LabW *self.dataArr.count, 0);
        
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [lab addGestureRecognizer:tap];
        
        //设置lab可以点击
        lab.userInteractionEnabled = YES;
        
        //把lab添加到频道数组里面
        [self.labM addObject:lab];
        
        // 创建标签时,默认把第0个标签缩放到最大
        if (i == 0) {
            lab.scale = 1.0;
        }
    }
}

//MARK: -点击频道的方法
- (void)tapClick:(UIGestureRecognizer *)tap{
    //获取选中的lab
    RYChanneiLab *lab = (RYChanneiLab *)tap.view;
    //计算选中的label居中时,要滚动的偏移量
    CGFloat laboffsetX = lab.center.x - self.view.bounds.size.width/2;
    
    //限制最大值和最小的偏移量
    CGFloat minoffsetX = 0;
    CGFloat maxoffsetX = self.ChannelScrollView.contentSize.width - self.view.bounds.size.width;
    if (laboffsetX < minoffsetX) {
        laboffsetX = 0;
    }else if (laboffsetX > maxoffsetX){
        laboffsetX = maxoffsetX;
    }
    
    //设置频道滚动视图的滚动
    [self.ChannelScrollView setContentOffset:CGPointMake(laboffsetX, 0) animated:YES];
    
    //MARK: - 点击频道标签居中时,collectionView也跟着联动
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:lab.tag inSection:0];
    [self.NewsCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:YES];
    
    //MARK: - 点击label时选中的缩放比例最大,其余的保持
    // 获取选中label的tag
    NSInteger index = lab.tag;
    
    for (int i = 0; i < self.labM.count; ++i) {
        // 遍历出所有的label
        RYChanneiLab *label = self.labM[i];
        // 把选中的缩放到最大
        if (index == i) {
            label.scale = 1.0;
        } else {
            label.scale = 0;
        }
    }
}

//MARK: - 一滚动就调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    CGFloat curPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
//
//    //左边label的角标
//    NSInteger leftIndex = curPage;
//    //右边label的角标
//    NSInteger rightIndex = leftIndex + 1;
//    
//    //获取左边label
//    UILabel *leftLabel = self.labM[leftIndex];
//    //获取右边label
//    UILabel *rightLabel;
//    if (rightIndex < self.labM.count - 1) {
//        rightLabel = self.labM[rightIndex];
//    }
//    
//    //计算右边缩放比例
//    CGFloat rightScale = curPage - leftIndex;
//    //计算左边缩放比例
//    CGFloat leftScale = 1-rightScale;
//    NSLog(@"左边索引=%zd 左边缩放比=%f 右边=索引%zd 右边缩放比=%f",leftLabel,leftScale,rightLabel,rightScale);
//    //左边缩放
//    leftLabel.transform = CGAffineTransformMakeScale(leftScale, leftScale);
//    //右边缩放
//    rightLabel.transform =CGAffineTransformMakeScale(rightScale, rightScale);
    
    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat W = self.view.bounds.size.width;
    
    // 获取浮点数的索引
    CGFloat index_float = offsetX / W;
    
    // 整数整型索引
    NSInteger index = offsetX / W;
    
    // 浮点数的索引 减 整型的索引 = 百分比
    CGFloat percent = index_float - index;
    //    NSLog(@"浮点数索引=%f 整型索引=%zd 百分比=%f",index_float,index,percent);
    
    // 要实现左右滚动的缩放,需要确定四个值 : 左边的索引,右边的索引,左边的缩放比,右边的缩放比
    
    // 左边的索引,就是当前的索引
    NSInteger left_index = index;
    // 右边的索引,就是左边的索引加1
    NSInteger right_index = left_index + 1;
    
    // 右边的缩放比
    CGFloat right_scale = percent;
    // 左边的缩放比
    CGFloat left_scale = 1 - right_scale;
    
    NSLog(@"左边索引=%zd 左边缩放比=%f 右边=索引%zd 右边缩放比=%f",left_index,left_scale,right_index,right_scale);
    
    // 取出左边索引对应的标签,设置对应的缩放比
    RYChanneiLab *left_label = self.labM[left_index];
    left_label.scale = left_scale;
    // 取出右边索引对应的标签,设置对应的缩放比
    if (right_index < self.labM.count) {
        RYChanneiLab *right_Label = self.labM[right_index];
        right_Label.scale = right_scale;
    }
}

#pragma mark - 监听底部conllectionView的滚动:滚动结束的代理的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //计算滚动到第几个索引
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    //根据标签去找lab
    RYChanneiLab *lab = self.labM[index];
    
    //lab滚动的偏移量
    CGFloat laboffSetX = lab.center.x - self.view.bounds.size.width/2;
    //限制最大便宜和最小偏移量
    CGFloat minOffsetX = 0;
    CGFloat manOffsetX = self.ChannelScrollView.contentSize.width - self.view.bounds.size.width;
    if (laboffSetX < minOffsetX) {
        laboffSetX = 0;
    }else if (laboffSetX > manOffsetX){
        laboffSetX = manOffsetX;
    }
    
    //真正滚动的channelScollview
    [self.ChannelScrollView setContentOffset:CGPointMake(laboffSetX, 0) animated:YES];
}

#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RYHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RYHomeViewController" forIndexPath:indexPath];
    RYChannelModel *model = self.dataArr[indexPath.item];
    //NSLog(@"model.tid %@",model.tid);
    
    //cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    NSString *urlstr = [NSString stringWithFormat:@"article/list/%@/0-20.html",model.tid];
    cell.urlstr = urlstr;
    
    return cell;
    
}

@end

