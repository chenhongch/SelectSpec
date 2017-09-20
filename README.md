# SelectSpec
仿淘宝购买时规格选择

### 1. 效果图

![type1](https://github.com/chenhongch/SelectSpec/blob/master/images/type1.gif)
![type2](https://github.com/chenhongch/SelectSpec/blob/master/images/type2.gif)
### 2. 视图解析
封装了商品数量选择UIView ->CountView

```
@interface CountView : UIView

/**
 默认数量
 */
@property (nonatomic, assign)NSInteger count;
/**
 最大库存
 */
@property (nonatomic, assign)NSInteger goodstock;

/**
 选择数量回调
 */
@property (nonatomic, copy)void (^CountBlock)(NSInteger num);

@end
```
规格选择UIView ->SelectSpecView
使用block一句代码回调选择数据
```
@interface SelectSpecView : UIView

/**
 数据源模型
 */
@property (nonatomic, retain)NSArray<SepecModel *> *dataArr;

/**
 用于确定比较规格模型数组 确定选择的是那组规格
 */
@property (nonatomic, retain)NSArray<compareSepecModel *> *comparedataArr;

/**
 选择完成后回调
 */
@property (nonatomic, copy)SelectSpecViewBlock block;
/**
 未选择完成后回调
 */
@property (nonatomic, copy)SelectSpecViewBlock inCompleteBlock;

+ (SelectSpecView*)selectSpecViewWithdataArr:(NSArray<SepecModel *> *)dataArr;

/**
 显示
 */
- (void)show;
/**
 隐藏
 */
- (void)hiddenView;

@end

```
### 3. 使用
数据模型格式需要满足 {规格:@"颜色",@"list"[{规格值:@"绿色"},{规格值:@"绿色"}]}

```
 SelectSpecView *seleView = [SelectSpecView selectSpecViewWithdataArr:allSepec];
 
        //传入比较数据
        seleView.comparedataArr = compareSepec; 
        
        //规格选择完全时 回调
        seleView.block = ^(NSString *skuid,NSString *price,NSString *num,NSString *sepec){
            _lab.text = [NSString stringWithFormat:@"skuid = %@ \n 实际价格= %@\n 数量= %@ \n 规格=%@",skuid,price,num,sepec];
        };
        
       //规格未选择完全时 回调
        seleView.inCompleteBlock =  ^(NSString *skuid,NSString *price,NSString *num,NSString *sepec){
            [sender setTitle:[NSString stringWithFormat:@"请选择  %@",sepec] forState:0];
       };

```
详情请见demo

### 4. 期待
如果在使用过程中遇到BUG，希望你能Issues我，谢谢。
如果有更好的优化方法，希望你能Issues我，谢谢。



