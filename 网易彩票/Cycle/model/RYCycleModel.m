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

#import "RYCycleModel.h"
#import "RYNetworlTools.h"

@implementation RYCycleModel

//字典转模型
+ (instancetype)CycleModelWithDic:(NSDictionary *)dic{
    
    RYCycleModel *model = [[RYCycleModel alloc]init];
    //KVC
    [model setValuesForKeysWithDictionary:dic];
    return model;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

//下载方法
+(void)loadCycleDataWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *listArr))successBlock failBlock:(void (^)(NSError *error))failBlock{
    
    [[RYNetworlTools sharedNetworlTool]GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        
        //NSLog(@"%@",responseObject);
        //取出key
        NSString *key = responseObject.keyEnumerator.nextObject;
        //数组
        NSArray *arr = [responseObject objectForKey:key];
        //可遍数组
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        
        //遍历
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           //模型
            RYCycleModel *model = [self CycleModelWithDic:obj];
            //模型添加到可变的数组里面
            [arrM addObject:model];
        }];
        //判断successBlock是否已经实现
        if (successBlock) {
            successBlock(arrM.copy);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) {
            failBlock(error);
        }
    }];
}

@end
