//
//  CountView.h
//  SelectSpec
//
//  Created by 陈楠 on 17/8/17.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

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
