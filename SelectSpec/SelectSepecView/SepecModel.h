//
//  SepecModel.h
//  SelectSpec
//
//  Created by 陈楠 on 17/8/17.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SepecDetailModel : NSObject

@property (nonatomic, copy)NSString *id_sepec;
@property (nonatomic, copy)NSString *presentid_sepec;
@property (nonatomic, copy)NSString *name_sepec;
@property (nonatomic) BOOL selected;
//用于计算文字大小
@property (strong, nonatomic) UIFont *font;

@property (nonatomic, readonly) CGSize contentSize;

- (instancetype)initWithName:(NSString *)name font:(UIFont *)font;

@end

@interface SepecModel : NSObject

@property (nonatomic, copy)NSString *id_sepec;
@property (nonatomic, copy)NSString *name_sepec;
@property (nonatomic, copy)NSString *price_sepec;
@property (nonatomic, retain)NSArray<SepecDetailModel *> *arr_sepec;
@end

@interface compareSepecModel : NSObject

@property (nonatomic, copy)NSString *goodspriceid;
@property (nonatomic, copy)NSString *spec_price;
@property (nonatomic, retain)NSArray *propertylist;
@end

