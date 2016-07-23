1:创建cell的三种样式
    basecell
    bigcell
    imagesCell
--------------------------------------------------------------
2：创建UIContainerView  轮播图
--------------------------------------------------------------
3:获取轮播图的数据，通过model进行下载
[[NetworkTool sharedNetworkTool] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
    
    //        NSLog(@"%@",responseObject);
    
    // 获取字典的第一个key
    NSString *key = responseObject.keyEnumerator.nextObject;
    // 获取轮播数据 (字典数组)
    NSArray *cycleArr = responseObject[key];
    
    // 定义临时数组
    NSMutableArray *tmpM = [NSMutableArray arrayWithCapacity:cycleArr.count];
    
    // 遍历字典数组转模型数组
    [cycleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CycleModel *model = [CycleModel cycleWithDict:obj];
        [tmpM addObject:model];
    }];
    
    if (successBlock) {
        successBlock(tmpM.copy);
    }
    
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
    if (failedBlock) {
        failedBlock(error);
    }
}];
--------------------------------------------------------------
4：展示轮播器界面
    其中需要注意：
    01：刷新完collectionView之后,默默的把item滚动到第4个 (cycleList.count)
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.cycleList.count inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
    02：/// 当停止滚动/减速之后,判断当前item是在第0个还是最后一个
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat scrollViewW = scrollView.bounds.size.width;
    
    // 获取当前的偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 计算当前在第几个item
    NSInteger index = offsetX / scrollViewW;
    

    
    // 准备索引
    NSIndexPath *indexPath;
    
    // 重新获取item的总个数 : 因为前面加倍了的
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    
    // 判断当前item是在第0个还是最后一个
    if (index == 0) {
        indexPath = [NSIndexPath indexPathForItem:self.cycleList.count inSection:0];
    } else if (index == items - 1) {
        indexPath = [NSIndexPath indexPathForItem:self.cycleList.count-1 inSection:0];
    }
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
}
--------------------------------------------------------------
5:添加pageController
/// 创建pageControl
- (void)createPageControl
{
    self.pageControl = [[UIPageControl alloc] init];
    [self.view addSubview:self.pageControl];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor blackColor];
}
// 获取pageControl的个数
self.pageControl.numberOfPages = cycleList.count;
// 计算pageControl的Size
CGSize pageControlSize = [self.pageControl sizeForNumberOfPages:cycleList.count];

// 计算pageControl的frame
CGFloat pageControlX = self.view.bounds.size.width - pageControlSize.width - 10;
CGFloat pageControlY = self.view.bounds.size.height - pageControlSize.height;
self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlSize.width, pageControlSize.height);

---------------------------------------------------------------

6：给频道添加点击事件
// 给标签添加点击手势
UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapClick:)];
// 添加手势
[label addGestureRecognizer:tap];
// 给label添加tag,点击时conllectionView联动可用
label.tag = i;
// 打开label的交互
label.userInteractionEnabled = YES;

#pragma mark - 频道标签的点击事件
- (void)labelTapClick:(UITapGestureRecognizer *)tap
{
    // 获取选中的频道标签
    ChannelLabel *label = (ChannelLabel *)tap.view;
    
    // 计算选中的label剧中时,要滚动的偏移量
    CGFloat labelOffsetX = label.center.x - (self.view.bounds.size.width * 0.5);
    
    // 限制最大和最小的偏移量
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = self.channelScrollView.contentSize.width - self.view.bounds.size.width;
    // 判断偏移量的临界值
    if (labelOffsetX < minOffsetX) {
        labelOffsetX = 0;
    } else if (labelOffsetX > maxOffsetX) {
        labelOffsetX = maxOffsetX;
    }
    
    // 设置频道滚动视图的滚动
    [self.channelScrollView setContentOffset:CGPointMake(labelOffsetX, 0) animated:YES];
    
#pragma mark - 点击频道标签剧中时,collectionView也跟着联动
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:label.tag inSection:0];
    [self.newsCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
}
--------------------------------------------------------------
7：上下联动
滚动scoller按钮也跟着滚动
#pragma mark - 监听底部conllectionView的滚动 : 滚动结束的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 计算当前滚动到第几个item (索引)
    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    
    // 拿着索引去标签数组找对应的标签
    ChannelLabel *label = self.labelM[index];
    
    // 计算选中的label剧中时,要滚动的偏移量
    CGFloat labelOffsetX = label.center.x - (self.view.bounds.size.width * 0.5);
    
    // 限制最大和最小的偏移量
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = self.channelScrollView.contentSize.width - self.view.bounds.size.width;
    // 判断偏移量的临界值
    if (labelOffsetX < minOffsetX) {
        labelOffsetX = 0;
    } else if (labelOffsetX > maxOffsetX) {
        labelOffsetX = maxOffsetX;
    }
    
    // 设置频道滚动视图的滚动
    [self.channelScrollView setContentOffset:CGPointMake(labelOffsetX, 0) animated:YES];
}

--------------------------------------------------------------











