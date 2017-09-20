

//
//  SelectSpecView.m
//  SelectSpec
//
//  Created by 陈楠 on 17/8/17.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//


#import "SelectSpecView.h"
#import "SepecModel.h"
#import "SepecConfig.h"
#import "CountView.h"
static NSString * const sepceCellID = @"sepecCellID";
static NSString * const headerViewID = @"headerViewID";
static NSString * const footerViewID = @"footerViewID";
#define SCREEN_BOUNDS   [UIScreen mainScreen].bounds
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define CommonGrayWhite [UIColor colorWithRed:222/255.0 green:223/255.0 blue:224/255.0 alpha:1] //分割线常用颜色
// 屏幕尺寸
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenBounds [UIScreen mainScreen].bounds
#define AUTOX(A) kScreenW * (A/kScreenW)
#define AUTOY(A) kScreenH * (A/kScreenH)
#define MaxX(v)            CGRectGetMaxX((v).frame) //横坐标加上控件的宽度
#define MaxY(v)            CGRectGetMaxY((v).frame) //纵坐标加上控件的高度
#define WI(v)           (v).frame.size.width
#define HE(v)          (v).frame.size.height

// 字体
#define SYSFont(a)     [UIFont systemFontOfSize:a]
#define BOLDFont(FONTSIZE) [UIFont boldSystemFontOfSize:FONTSIZE]

//UICollectionViewFlowLayout 我对其自定义有问题

@interface AddAttriCollReusableView : UICollectionReusableView

@property (nonatomic, retain)UILabel *headerLab;

@property (nonatomic, assign)NSInteger section;


- (void)setAttriHeaderTitle:(NSString *)title;
- (void)setAttriFooterTitle:(NSString *)title;

@end

@implementation AddAttriCollReusableView

- (void)setAttriHeaderTitle:(NSString *)title{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 31)];
    view.tag = _section+10;
    [self addSubview:view];
    UIView *line = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, kScreenW - 10, 1)];
    line.backgroundColor = [UIColor grayColor];
    [view addSubview:line];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(14, 1, kScreenW - 2*14, 30)];
    lab.textColor = [UIColor darkGrayColor];
    lab.font = SYSFont(15);
    [view addSubview:lab];
    self.headerLab = lab;
    self.headerLab.text = title;
}

- (void)setAttriFooterTitle:(NSString *)title{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 35)];
    [self addSubview:view];
    
    
}


@end



@interface sepecCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *sepeclabel;
@property (nonatomic) SepecDetailModel *sepceModel;
@property (nonatomic) UIEdgeInsets contentInsets;

@end

@implementation sepecCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        _sepeclabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 35)];
        _sepeclabel.textAlignment = NSTextAlignmentCenter;
        _sepeclabel.userInteractionEnabled = NO;
        _sepeclabel.textColor = [UIColor blackColor];
        _sepeclabel.font = SYSFont(15);
        
        [self.contentView addSubview:_sepeclabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect bounds = self.contentView.bounds;
    CGFloat width = bounds.size.width - self.contentInsets.left - self.contentInsets.right;
    CGRect frame = CGRectMake(0, 0, width, self.sepceModel.contentSize.height);
    self.sepeclabel.frame = frame;
    self.sepeclabel.center = self.contentView.center;
}



@end


@interface SelectSpecView ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray<NSString *> *tagsMutableArray;
@property (nonatomic, retain)SepecConfig *config;
@property (nonatomic, retain)UIView *contentView;
@property (nonatomic, retain)UIView *bgView;

@property (nonatomic, retain)UILabel *spec_price;
@property (nonatomic, retain)UILabel *specLab;

@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)NSString *priceid;
@property (nonatomic, copy)NSString *num;
@property (nonatomic, copy)NSString *compeleteStr;//选中的规格
@property (nonatomic, assign)BOOL iscompelete;//判断是否选择完全
@property (nonatomic, retain)NSMutableArray *tempSelectArr;//临时存储选择中的模型

@end

@implementation SelectSpecView

+ (SelectSpecView*)selectSpecViewWithdataArr:(NSArray<SepecModel *> *)dataArr{
    //初始化
    SelectSpecView *sepecView = [[SelectSpecView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withDataArr:dataArr];
    [sepecView show];
     [[UIApplication sharedApplication].keyWindow addSubview:sepecView];
    return  sepecView;
}
- (void)show{
  self.hidden = self.contentView.hidden= self.bgView.hidden = NO;
    [UIView animateWithDuration:0.5f animations:^{
       self.contentView.frame = CGRectMake(0, kScreenH/2-50, kScreenW, kScreenH/2+50);
    }];
}

- (void)hiddenView{
    [UIView animateWithDuration:0.5f animations:^{
       
        self.contentView.frame = CGRectMake(0, kScreenH, kScreenW, kScreenH/2+50);
    } completion:^(BOOL finished) {
        self.hidden = self.contentView.hidden=self.bgView.hidden = YES;
    }];
   }
- (void)setDataArr:(NSArray<SepecModel *> *)dataArr{
    _dataArr = dataArr;
    [self.collectionView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame withDataArr:(NSArray<SepecModel *> *)dataArr{
     [self setupConfig];
    self.dataArr = dataArr;
    if (self = [super initWithFrame:frame]) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        bgView.backgroundColor = [UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:0.2];
        [self addSubview:bgView];
        bgView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenView)];
        [bgView addGestureRecognizer:tap];
        
        UIView *contentview = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH, kScreenW, kScreenH/2+50)];
        contentview.backgroundColor = [UIColor whiteColor];
        bgView.hidden = YES;
        [self addSubview:contentview];
        
        self.contentView = contentview;
        self.bgView = bgView;
     [self otherViews];
     [self addInitCollectView];
        
    }
    return self;
}
#pragma mark - 头部视图 需要展示数据 如销量之类的 可在这里添加
- (void)otherViews{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 50, 50)];
    imageView.image = [UIImage imageNamed:@"p1@2x"];
    [self.contentView addSubview:imageView];
    
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(MaxX(imageView)+10, 15, kScreenH/2, 30)];
    price.textColor = [UIColor redColor];
    price.font = SYSFont(15);
    self.spec_price = price;
    [self.contentView addSubview:price];
    price.text = @"￥0.00";
    
    UILabel *sepelab = [[UILabel alloc]initWithFrame:CGRectMake(MaxX(imageView)+10, MaxY(price), kScreenH/2, 30)];
    sepelab.textColor = [UIColor darkGrayColor];
    sepelab.font = SYSFont(15);
    self.specLab = sepelab;
    [self.contentView addSubview:sepelab];
    NSString *str = @"";
    for (SepecModel *mo in _dataArr) {
        str = [NSString stringWithFormat:@"%@ %@",str,mo.name_sepec];
    }
    sepelab.text = [NSString stringWithFormat:@"选择 %@", str];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = SYSFont(14);
    [btn setTitleColor:[UIColor orangeColor] forState:0];
    [btn setTitle:@"取消" forState:0];
    btn.frame = CGRectMake(kScreenW - 65, 10, 50, 30);
    [btn addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    
}
#pragma mark - UICollectionView基础属性设置
- (void)setupConfig{
    _num = @"1";
    _config = [[SepecConfig alloc]init];
    _config.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
   _config.sepecInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    _config.sepecBorderWidth = 0;
    _config.sepecBackgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    _config.sepecSelectedBackgroundColor = [UIColor colorWithRed:1.0 green:0.38 blue:0.0 alpha:1.0];
    _config.sepecFont = [UIFont systemFontOfSize:14];
    _config.sepecSelectedFont = [UIFont systemFontOfSize:14];
    _config.sepecTextColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    _config.sepecSelectedTextColor = [UIColor whiteColor];
    
    _config.sepecHeight = 28;
    _config.mininumsepecWidth = 0;
    _config.maximumsepecWidth = CGFLOAT_MAX;
    _config.lineSpacing = 10;
    _config.interitemSpacing = 5;
}

#pragma mark - collectionView
- (void)addInitCollectView{

    //1.初始化layout
     UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.itemSize = CGSizeMake(kScreenW/5, 40);
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    

    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, AUTOY(80), kScreenW, HE(_contentView) -  AUTOY(120)) collectionViewLayout:layout];
    [self.collectionView registerClass:[sepecCell class] forCellWithReuseIdentifier:sepceCellID];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewID];
     [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerViewID];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    _collectionView.allowsSelection = YES;
    [self.contentView addSubview:self.collectionView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, HE(self.contentView) - AUTOY(40), kScreenW, AUTOY(40));
    btn.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:btn];
    [btn setTitle:@"确定" forState:0];
    btn.titleLabel.font = SYSFont(15);
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - 确定规格选择---根据项目需要返回指定数据
- (void)btnAction:(UIButton *)sender{
   
    if (!_iscompelete) {
        if (_inCompleteBlock) {
            _inCompleteBlock(@"0",@"0.00",@"1",_compeleteStr);
        }
    }else{
        [self hiddenView];
        if (_block) {
            _block(_priceid,_price,_num,_compeleteStr);
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    SepecModel *model = _dataArr[section];
    return model.arr_sepec.count;
}
// 返回格子有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    sepecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sepceCellID forIndexPath:indexPath];
    
    SepecModel *model = self.dataArr[indexPath.section];
    SepecDetailModel *sepecModel = model.arr_sepec[indexPath.row];
    cell.sepceModel = sepecModel;
    NSLog(@"====cell====%@",sepecModel.name_sepec);
    cell.sepeclabel.text = sepecModel.name_sepec;
    cell.layer.cornerRadius = self.config.sepeccornerRadius;
    cell.layer.masksToBounds = self.config.sepeccornerRadius > 0;
//    cell.contentInsets = self.config.sepecInsets;
    cell.layer.borderWidth = self.config.sepecBorderWidth;
    [self setCell:cell selected:sepecModel.selected];
    
    return cell;
}

- (void)setCell:(sepecCell *)cell selected:(BOOL)selected {
    
    if (selected) {
        cell.backgroundColor = self.config.sepecSelectedBackgroundColor;
        cell.sepeclabel.font = self.config.sepecSelectedFont;
        cell.sepeclabel.textColor = self.config.sepecSelectedTextColor;
        cell.layer.borderColor = self.config.sepecSelectedBorderColor.CGColor;
    }else {
        cell.backgroundColor = self.config.sepecBackgroundColor;
        cell.sepeclabel.font = self.config.sepecFont;
        cell.sepeclabel.textColor = self.config.sepecTextColor;
        cell.layer.borderColor = self.config.sepecBorderColor.CGColor;
    }
}

////头部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
      
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewID forIndexPath:indexPath];
        SepecModel *model = _dataArr[indexPath.section];
        [headerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];//每次刷新 移除子视图 不然会重叠😭
        
        UIView *line = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, kScreenW - 10, 1)];
        line.backgroundColor = CommonGrayWhite;
        [headerView addSubview:line];
        
        UILabel *sepecNamelab = [[UILabel alloc]initWithFrame:CGRectMake(14, 1, kScreenW - 2*14, 30)];
        sepecNamelab.textColor = [UIColor darkGrayColor];
        sepecNamelab.font = SYSFont(15);
        sepecNamelab.text = model.name_sepec;
        [headerView addSubview:sepecNamelab];
      

        return headerView;
    }else{
        if (_dataArr.count-1 == indexPath.section) {
           UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerViewID forIndexPath:indexPath];
            UIView *line = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, kScreenW - 10, 1)];
            line.backgroundColor = CommonGrayWhite;
            [headerView addSubview:line];

            UIView *countbgview = [[UIView alloc]initWithFrame:CGRectMake(0, 1, kScreenW, 49)];
            countbgview.backgroundColor = [UIColor whiteColor];
            [headerView addSubview:countbgview];
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, kScreenW/2, 39)];
            lab.text = @"购买数量: ";
            lab.textColor = [UIColor blackColor];
            lab.font = SYSFont(15);
            [countbgview addSubview:lab];
            
            CountView *view = [[CountView alloc]initWithFrame:CGRectMake(WI(countbgview) - 115, 19/2, 100, 30)];
            view.count = 1;
            view.goodstock = 1000000;//可选择的最大销量
            view.CountBlock = ^(NSInteger count){
                self.num = [NSString stringWithFormat:@"%ld",(long)count];
            };
            [countbgview addSubview:view];
            return headerView;
        }else{
            return nil;
        }
    }
//  return headerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenW, 31);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (_dataArr.count - 1 == section) {
         return CGSizeMake(kScreenW, 50);
    }
    return CGSizeMake(0, 0);
}


#pragma mark - ......::::::: UICollectionViewDelegate :::::::......
// 选中操作
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SepecModel *model = self.dataArr[indexPath.section];
    SepecDetailModel *sepecModel = model.arr_sepec[indexPath.item];
    
    sepecModel.selected =  !sepecModel.selected;
    
    if (sepecModel.selected) {
        for (SepecDetailModel *mo in model.arr_sepec) {
            if (sepecModel != mo) {
                mo.selected = NO;
            }
        }
    }
    
    _tempSelectArr = [NSMutableArray array];
    NSMutableArray *preflagarr = [NSMutableArray array];
    for (SepecModel *model in _dataArr) {
        for (SepecDetailModel *demodel in model.arr_sepec) {
            if (demodel.selected == YES) {
                [_tempSelectArr addObject:demodel];
                [preflagarr addObject:model];
                break;
            }
        }
    }
    
    if (preflagarr.count == _dataArr.count) {//选择的个数等于组数
        NSString *str = @"";
        for (SepecDetailModel *demodel in _tempSelectArr) {
            str = [NSString stringWithFormat:@"%@ %@",str,demodel.name_sepec];
        }
        self.specLab.text  = [NSString stringWithFormat:@"已选择 %@",str];
        
        //确定选择哪个sku
        BOOL isJump = false;
        int jumpNum = 0;
            for (compareSepecModel *compareModel in _comparedataArr) {
                jumpNum = 0;
                for (SepecDetailModel *demodel in _tempSelectArr ) {
                    if ([compareModel.goodspriceid rangeOfString:demodel.id_sepec].location != NSNotFound) {
                      
                        jumpNum ++;
                        if (jumpNum == _tempSelectArr.count) {
                            self.spec_price.text = [NSString stringWithFormat:@"￥%0.2f",[compareModel.spec_price floatValue]];
                            self.price = compareModel.spec_price;
                            self.priceid = compareModel.goodspriceid;
                            isJump = true;
                            break;
                        }
                    }
                    if (isJump) {
                        break;
                    }
                }
               
            }
        
        _iscompelete = YES;
         _compeleteStr = str;
        
    }else{
        NSMutableArray *dataCopy = [NSMutableArray array];
        dataCopy = [_dataArr mutableCopy];
        NSString *str = @"";
        for (SepecModel *demodel in preflagarr) {
            [dataCopy removeObject:demodel];//移除已经选择的
        }
        for (SepecModel *demodel in dataCopy) {//取出未选择的
           str = [NSString stringWithFormat:@"%@ %@",str,demodel.name_sepec];
        }
        self.specLab.text  = [NSString stringWithFormat:@"请选择 %@",str];
        self.spec_price.text = @"￥0.00";//没有选择完全时，价格为0
        _compeleteStr = str;
        _iscompelete = NO;//状态为NO
    }
    
    [collectionView reloadData];

    NSLog(@"666 %s", __FUNCTION__);
}



#pragma mark - ......::::::: UICollectionViewDelegateFlowLayout :::::::......

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    SepecModel *model = self.dataArr[indexPath.section];
    SepecDetailModel *sepecModle = model.arr_sepec[indexPath.row];
    CGFloat width = sepecModle.contentSize.width + self.config.sepecInsets.left + self.config.sepecInsets.right;
    if (width < self.config.mininumsepecWidth) {
        width = self.config.mininumsepecWidth;
    }
    if (width > self.config.maximumsepecWidth) {
        width = self.config.maximumsepecWidth;
    }
    
    return CGSizeMake(width, self.config.sepecHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.config.interitemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.config.lineSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return self.config.contentInsets;
}


@end





