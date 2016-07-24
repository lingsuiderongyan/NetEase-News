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

#import "RYChanneiLab.h"

@implementation RYChanneiLab

//标签居中
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    // 字体颜色渐变
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
    
    // 限制最大和最小的缩放比
    CGFloat minScale = 1.0;
    CGFloat maxScale = 1.2;
    
    //  scale = 1.0 + (0.2) * scale
    
    scale = minScale + (maxScale - minScale) *scale;
    
    // 控件大小缩放
    self.transform = CGAffineTransformMakeScale(scale, scale);
}
@end
