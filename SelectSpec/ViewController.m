//
//  ViewController.m
//  SelectSpec
//
//  Created by 陈楠 on 17/8/17.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import "ViewController.h"
#import "SepecModel.h"
#import "SelectSpecView.h"

@interface ViewController ()
@property (nonatomic ,retain)UILabel *lab;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(50, 200, self.view.frame.size.width - 100, 44);
    [self.view addSubview:btn];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitle:@"点击选择规格" forState:0];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _lab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(btn.frame)+20, self.view.frame.size.width - 40, 200)];
    _lab.numberOfLines = 0;
    _lab.textAlignment = 0;
    _lab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_lab];

 }

- (void)btnAction:(UIButton *)sender{
    //公司后台返回的数据
//    NSArray *arr = @[
//                     @{
//                         @"goodspriceid": @"23",
//                         @"spec_price": @"520",
//                         @"propertylist": @[
//                                 @{
//                                     @"spec_id": @"57",
//                                     @"spec_name": @"尺寸",
//                                     @"sprc_id": @"68",
//                                     @"sprc_value": @"120寸"
//                                     },
//                                 @{
//                                     @"spec_id": @"56",
//                                     @"spec_name": @"颜色",
//                                     @"sprc_id": @"37",
//                                     @"sprc_value": @"绿色"
//                                     }
//                                 ]
//                         },
//                     @{
//                         @"goodspriceid": @"23",
//                         @"spec_price": @"520",
//                         @"propertylist": @[
//                                 @{
//                                     @"spec_id": @"57",
//                                     @"spec_name": @"尺寸",
//                                     @"sprc_id": @"60",
//                                     @"sprc_value": @"60寸"
//                                     },
//                                 @{
//                                     @"spec_id": @"56",
//                                     @"spec_name": @"颜色",
//                                     @"sprc_id": @"37",
//                                     @"sprc_value": @"绿色"
//                                     }
//                                 ]
//                         },@{
//                         @"goodspriceid": @"23",
//                         @"spec_price": @"520",
//                         @"propertylist": @[
//                                 @{
//                                     @"spec_id": @"57",
//                                     @"spec_name": @"尺寸",
//                                     @"sprc_id": @"68",
//                                     @"sprc_value": @"120寸"
//                                     },
//                                 @{
//                                     @"spec_id": @"56",
//                                     @"spec_name": @"颜色",
//                                     @"sprc_id": @"67",
//                                     @"sprc_value": @"黄色"
//                                     }
//                                 ]
//                         },@{
//                         @"goodspriceid": @"29",
//                         @"spec_price": @"59",
//                         @"propertylist": @[
//                                 @{
//                                     @"spec_id": @"57",
//                                     @"spec_name": @"尺寸",
//                                     @"sprc_id": @"78",
//                                     @"sprc_value": @"130寸"
//                                     },
//                                 @{
//                                     @"spec_id": @"56",
//                                     @"spec_name": @"颜色",
//                                     @"sprc_id": @"67",
//                                     @"sprc_value": @"黄色"
//                                     }
//                                 ]
//                         },@{
//                         @"goodspriceid": @"29",
//                         @"spec_price": @"50",
//                         @"propertylist": @[
//                                 @{
//                                     @"spec_id": @"57",
//                                     @"spec_name": @"尺寸",
//                                     @"sprc_id": @"78",
//                                     @"sprc_value": @"130寸"
//                                     },
//                                 @{
//                                     @"spec_id": @"56",
//                                     @"spec_name": @"颜色",
//                                     @"sprc_id": @"37",
//                                     @"sprc_value": @"绿色"
//                                     }
//                                 ]
//                         },@{
//                         @"goodspriceid": @"23",
//                         @"spec_price": @"520",
//                         @"propertylist": @[
//                                 @{
//                                     @"spec_id": @"57",
//                                     @"spec_name": @"尺寸",
//                                     @"sprc_id": @"60",
//                                     @"sprc_value": @"60寸"
//                                     },
//                                 @{
//                                     @"spec_id": @"56",
//                                     @"spec_name": @"颜色",
//                                     @"sprc_id": @"67",
//                                     @"sprc_value": @"黄色"
//                                     }
//                                 ]
//                         }
//                     ];
//    NSMutableArray *allSectionSepec = [NSMutableArray array];//规格组
//    NSMutableArray *allSectionModel = [NSMutableArray array];//规格值
//    NSMutableArray *allSepec = [NSMutableArray array];
//    NSMutableArray *compareSepec = [NSMutableArray array];
//    
//    
//    //所以的规格
//    for (NSDictionary *dict in arr) {
//        compareSepecModel *compareM = [[compareSepecModel alloc]init];
//        compareM.goodspriceid = dict[@"goodspriceid"];
//        compareM.spec_price = dict[@"spec_price"];
//        compareM.propertylist = dict[@"propertylist"];
//        [compareSepec addObject:compareM];//组合数量组
//        
//        for (NSDictionary *sedic in dict[@"propertylist"]) {
//        SepecDetailModel *sepecmodel = [[SepecDetailModel alloc]initWithName:sedic[@"sprc_value"] font:[UIFont systemFontOfSize:15]];
//        sepecmodel.id_sepec = [NSString stringWithFormat:@"%@",sedic[@"sprc_id"]];
//        sepecmodel.name_sepec = sedic[@"sprc_value"];
//        sepecmodel.presentid_sepec = sedic[@"spec_id"];
//        [allSepec addObject:sepecmodel];//所有的规格值
//        }
//    }
//    
//    //去掉重复的规格
//    NSMutableArray *sortAllSepe = [NSMutableArray array];
//    for (int i = 0; i < allSepec.count; i ++) {
//        
//        SepecDetailModel *isemodel = allSepec[i];
//         [sortAllSepe addObject:isemodel];
//        
//        for (NSInteger j = allSepec.count-1; j >i; j --) {
//            NSLog(@"====mum====%ld",(long)j);
//        SepecDetailModel *jsemodel = allSepec[j];
//        if ([isemodel.id_sepec isEqualToString:jsemodel.id_sepec]) {
//            [allSepec removeObject:jsemodel];
//            break;
//        }
//      }
//    }
//    
//    for (int i = 0; i < allSepec.count; i ++) {
//        SepecDetailModel *isemodel = allSepec[i];
//        NSLog(@"========测试====%@=",isemodel.name_sepec);
//    }
//    
//    
////获取规格组的名称 如颜色 只需要一组就可以了获取到了
//    NSArray *propertylist = arr[0][@"propertylist"];
//    for (NSDictionary *sedic in propertylist) {
//        SepecModel *model = [[SepecModel alloc]init];
//        model.id_sepec = sedic[@"spec_id"];
//        model.name_sepec = sedic[@"spec_name"];
//        [allSectionSepec addObject:model];
//    }
//    
//    for (SepecModel *mo in allSectionSepec) {
//        NSMutableArray *list = [NSMutableArray array];
//        for (SepecDetailModel *smo in allSepec) {
//            if ([mo.id_sepec isEqualToString:smo.presentid_sepec]) {
//                [list addObject:smo];//得到规格组下面的规格值 如颜色下面的 黄色、红色
//            }
//        }
//        mo.arr_sepec = list;
//        [allSectionModel addObject:mo];
//    }
//    
//    sender.selected = !sender.selected;
//    
//    SelectSpecView *seleView = [SelectSpecView selectSpecViewWithdataArr:allSectionModel];
//    seleView.comparedataArr = compareSepec;
//    seleView.block = ^(NSString *skuid,NSString *price,NSString *num){
//        [sender setTitle:[NSString stringWithFormat:@"skuid = %@ 实际价格= %@ 数量= %@",skuid,price,num] forState:0];
//    };
//    if (sender.selected) {
//       [seleView show];
//    }
    
    
    
#pragma 模拟数据
    //自己写的模拟数据 逻辑处理都是一样的
    // 两组规格演示
//    NSDictionary *dict = @{@"compare_sepec":@[@{@"skuid":@"13",@"skuPrice":@"452"},@{@"skuid":@"14",@"skuPrice":@"467"},@{@"skuid":@"15",@"skuPrice":@"55"},@{@"skuid":@"10",@"skuPrice":@"79"},@{@"skuid":@"23",@"skuPrice":@"42"},@{@"skuid":@"24",@"skuPrice":@"78"},@{@"skuid":@"25",@"skuPrice":@"34"},@{@"skuid":@"20",@"skuPrice":@"100"}],@"sepecList":@[
//                                                           @{
//                                                               @"goodspriceid": @"23",
//                                                               @"spec_name": @"颜色",
//                                                               @"spec_price": @"100",
//                                                               @"propertylist": @[
//                                                                       @{
//                                                                           @"sprc_id": @"1",
//                                                                           @"sprc_value": @"120寸"
//                                                                           },
//                                                                       @{
//                                                                           
//                                                                           @"sprc_id": @"2",
//                                                                           @"sprc_value": @"60寸"
//                                                                           }
//                                                                       ]
//                                                               },
//                                                           @{
//                                                               @"goodspriceid": @"24",
//                                                               @"spec_name": @"尺寸",
//                                                               @"spec_price": @"89",
//                                                               @"propertylist": @[
//                                                                       @{
//                                                                           
//                                                                           @"sprc_id": @"3",
//                                                                           @"sprc_value": @"红色"
//                                                                           },
//                                                                       @{
//                                                                           @"sprc_id": @"4",
//                                                                           @"sprc_value": @"绿色"
//                                                                           },
//                                                                       @{
//                                                                           @"sprc_id": @"5",
//                                                                           @"sprc_value": @"卡其色"
//                                                                           },
//                                                                       @{
//                                                                           @"sprc_id": @"0",
//                                                                           @"sprc_value": @"80块包邮哦"
//                                                                           }
//                                                                       ]
//                                                               }
//                                                           ]};
    
 //三组规格演示
    NSDictionary *dict = @{@"compare_sepec":@[@{@"skuid":@"041",@"skuPrice":@"452"},@{@"skuid":@"042",@"skuPrice":@"467"},@{@"skuid":@"031",@"skuPrice":@"55"},@{@"skuid":@"032",@"skuPrice":@"79"},@{@"skuid":@"941",@"skuPrice":@"42"},@{@"skuid":@"942",@"skuPrice":@"78"},@{@"skuid":@"931",@"skuPrice":@"34"},@{@"skuid":@"932",@"skuPrice":@"100"}],@"sepecList":@[
                                   @{
                                       @"goodspriceid": @"23",
                                       @"spec_name": @"尺寸",
                                       @"spec_price": @"100",
                                       @"propertylist": @[
                                               @{
                                                   @"sprc_id": @"1",
                                                   @"sprc_value": @"120寸"
                                                   },
                                               @{
                                                   
                                                   @"sprc_id": @"2",
                                                   @"sprc_value": @"60寸"
                                                   }
                                               ]
                                       },
                                   @{
                                       @"goodspriceid": @"24",
                                       @"spec_name": @"颜色",
                                       @"spec_price": @"89",
                                       @"propertylist": @[
                                               @{
                                                   
                                                   @"sprc_id": @"3",
                                                   @"sprc_value": @"红色"
                                                   },
                                               @{
                                                   @"sprc_id": @"4",
                                                   @"sprc_value": @"绿色"
                                                   }
                                               ]
                                       },
                                   @{
                                       @"goodspriceid": @"24",
                                       @"spec_name": @"优惠",
                                       @"spec_price": @"89",
                                       @"propertylist": @[
                                                    @{
                                                   @"sprc_id": @"0",
                                                   @"sprc_value": @"80块包邮哦"
                                                   },@{
                                                        @"sprc_id": @"9",
                                                        @"sprc_value": @"标配版"
                                                        }
                                               ]
                                       }
                                   ]};

    
    
        NSMutableArray *allSepec = [NSMutableArray array];
        NSMutableArray *compareSepec = [NSMutableArray array];
    
    
        //所以的规格
    NSArray *compare_arr = dict[@"compare_sepec"];
    for (NSDictionary *comparedict in compare_arr) {
        compareSepecModel *compareM = [[compareSepecModel alloc]init];
        compareM.goodspriceid = comparedict[@"skuid"];
        compareM.spec_price = comparedict[@"skuPrice"];
        [compareSepec addObject:compareM];//组合数量组
    }
    
       NSArray *arr = dict[@"sepecList"];
        for (NSDictionary *dict in arr) {
           
            SepecModel *sepecM = [[SepecModel alloc]init];
            sepecM.id_sepec = dict[@"goodspriceid"];
            sepecM.name_sepec = dict[@"spec_name"];
            sepecM.price_sepec = dict[@"spec_price"];
            [allSepec addObject:sepecM];//组合数量组
            
          NSMutableArray *allSepeclist = [NSMutableArray array];
            for (NSDictionary *sedic in dict[@"propertylist"]) {
            SepecDetailModel *sepecmodel = [[SepecDetailModel alloc]initWithName:sedic[@"sprc_value"] font:[UIFont systemFontOfSize:15]];
            sepecmodel.id_sepec = [NSString stringWithFormat:@"%@",sedic[@"sprc_id"]];
            sepecmodel.name_sepec = sedic[@"sprc_value"];
            [allSepeclist addObject:sepecmodel];//所有的规格值
            }
            sepecM.arr_sepec = allSepeclist;
        }
    
    
    
    
       sender.selected = !sender.selected;
    
        SelectSpecView *seleView = [SelectSpecView selectSpecViewWithdataArr:allSepec];
        sender.selected ?[seleView show]:nil;
        seleView.comparedataArr = compareSepec;
        seleView.block = ^(NSString *skuid,NSString *price,NSString *num,NSString *sepec){
            _lab.text = [NSString stringWithFormat:@"skuid = %@ \n 实际价格= %@\n 数量= %@ \n 规格=%@",skuid,price,num,sepec];
            [sender setTitle:@"选择完成" forState:0];
        };
        seleView.inCompleteBlock =  ^(NSString *skuid,NSString *price,NSString *num,NSString *sepec){
            [sender setTitle:[NSString stringWithFormat:@"请选择  %@",sepec] forState:0];
       };
    
  }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
