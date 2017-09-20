

//
//  SepecModel.m
//  SelectSpec
//
//  Created by 陈楠 on 17/8/17.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import "SepecModel.h"
/*
 @{
 @"goodspriceid": @"23",
 @"spec_price": @"520",
 @"propertylist": @[
 @{
 @"spec_id": @"57",
 @"spec_name": @"尺寸",
 @"sprc_id": @"68",
 @"sprc_value": @"56"
 },
 @{
 @"spec_id": @"56",
 @"spec_name": @"颜色",
 @"sprc_id": @"67",
 @"sprc_value": @"黄色"
 }
 ]
 }

 */


@implementation compareSepecModel

@end

@implementation SepecModel

@end


@implementation SepecDetailModel
- (instancetype)initWithName:(NSString *)name font:(UIFont *)font {
    if (self = [super init]) {
        _name_sepec = name;
        self.font = font;
    }
    return self;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    [self calculateContentSize];
}

- (void)calculateContentSize {
    NSDictionary *dict = @{NSFontAttributeName: self.font};
    CGSize textSize = [_name_sepec boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 1000)
                                                options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    _contentSize = CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

@end
