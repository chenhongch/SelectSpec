//
//  SelectSpecView.h
//  SelectSpec
//
//  Created by 陈楠 on 17/8/17.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SepecModel.h"

typedef void(^SelectSpecViewBlock)(NSString *skuid,NSString *price,NSString *num,NSString *sepec);

@interface SelectSpecView : UIView

/**
 数据源模型
 */
@property (nonatomic, retain)NSArray<SepecModel *> *dataArr;

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
