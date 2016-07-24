/**
 *
 * ......................我佛慈悲.......................
 *                       _oo0oo_
 *                      o8888888o
 *                      88" . "88
 *                      (| -_- |)
 *                      0\  =  /0
 *                    ___/`---'\___
 *                  .' \\|     |// '.
 *                 / \\|||  :  |||// \
 *                / _||||| -卍-|||||- \
 *               |   | \\\  -  /// |   |
 *               | \_|  ''\---/''  |_/ |
 *               \  .-\__  '-'  ___/-. /
 *             ___'. .'  /--.--\  `. .'___
 *          ."" '<  `.___\_<|>_/___.' >' "".
 *         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
 *         \  \ `_.   \_ __\ /__ _/   .-` /  /
 *     =====`-.____`.___ \_____/___.-`___.-'=====
 *                       `=---='
 *
 *..................佛祖开光 ,永无BUG....................
 *         CSDN博客:http://blog.csdn.net/song5347
 *       github地址:https://github.com/lingsuiderongyan
 *             邮箱:lingsuiderongyan@163.com
 */

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
