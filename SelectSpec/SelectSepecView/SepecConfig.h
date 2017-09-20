//
//  SepecConfig.h
//  SelectSpec
//
//  Created by 陈楠 on 17/8/17.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SepecConfig : NSObject
@property (nonatomic) UIEdgeInsets contentInsets; //default is (10,10,10,10)
@property (nonatomic) UIEdgeInsets sepecInsets; // default is (5,5,5,5)
@property (nonatomic) CGFloat sepecBorderWidth;           //标签边框宽度, default is 0
@property (nonatomic) CGFloat sepeccornerRadius;  // default is 0
@property (strong, nonatomic) UIColor *sepecBorderColor;
@property (strong, nonatomic) UIColor *sepecSelectedBorderColor;
@property (strong, nonatomic) UIColor *sepecBackgroundColor;
@property (strong, nonatomic) UIColor *sepecSelectedBackgroundColor;
@property (strong, nonatomic) UIFont *sepecFont;
@property (strong, nonatomic) UIFont *sepecSelectedFont;
@property (strong, nonatomic) UIColor *sepecTextColor;
@property (strong, nonatomic) UIColor *sepecSelectedTextColor;
@property (nonatomic) CGFloat lineSpacing;       //行间距, 默认为10
@property (nonatomic) CGFloat interitemSpacing; //元素之间的间距，默认为5
@property (nonatomic) CGFloat sepecHeight;        //标签高度，默认28
@property (nonatomic) CGFloat mininumsepecWidth;  //sepec 最小宽度值, 默认是0，即不作最小宽度限制
@property (nonatomic) CGFloat maximumsepecWidth;  //sepec 最大宽度值, 默认是CGFLOAT_MAX， 即不作最大宽度限制
@end
