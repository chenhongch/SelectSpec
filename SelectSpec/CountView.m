//
//  CountView.m
//  SelectSpec
//
//
//  Created by 陈楠 on 17/8/17.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import "CountView.h"

#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
@interface CountView ()<UITextFieldDelegate>
@property (nonatomic, strong)UIButton * leftBtn;
@property (nonatomic, strong)UIButton * rightBtn;
@property (nonatomic, strong)UIView * leftLineView;
@property (nonatomic, strong)UIView * rightLineView;
@property (nonatomic, strong)UITextField * countTF;

@end
@implementation CountView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftBtn];
        [self addSubview:self.leftLineView];
        [self addSubview:self.countTF];
        [self addSubview:self.rightLineView];
        [self addSubview:self.rightBtn];
        self.layer.cornerRadius = 3;
        self.layer.borderWidth = 1;
        self.layer.borderColor = RGBAColor(240, 240, 240, 1).CGColor;
//        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addSubview:self.leftBtn];
        [self addSubview:self.leftLineView];
        [self addSubview:self.countTF];
        [self addSubview:self.rightLineView];
        [self addSubview:self.rightBtn];
        self.layer.cornerRadius = 3;
        self.layer.borderWidth = 1;
        self.layer.borderColor = RGBAColor(200, 200, 200, 1).CGColor;
        //        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

#pragma mark -- LazyLoding
-(UIButton *)leftBtn{
    if (_leftBtn == nil) {
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, 0, self.frame.size.width * 2/7, self.frame.size.height);
        [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_leftBtn setImage:[UIImage imageNamed:@"shopCar_cut"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(cutBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

-(UIView *)leftLineView{
    if (_leftLineView == nil) {
        self.leftLineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftBtn.frame), 0, 1, self.frame.size.height)];
        _leftLineView.backgroundColor = RGBAColor(240, 240, 240, 1);
    }
    return _leftLineView;
}

- (UITextField *)countTF{
    if (_countTF == nil) {
        self.countTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftLineView.frame), 0, self.frame.size.width * 3/7 - 1, self.frame.size.height)];
        _countTF.font = [UIFont systemFontOfSize:14];
        _countTF.textAlignment = NSTextAlignmentCenter;
        _countTF.keyboardType = UIKeyboardTypeNumberPad;
        _countTF.delegate = self;
    }
    return _countTF;
}

-(UIView *)rightLineView{
    if (_rightLineView == nil) {
        self.rightLineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_countTF.frame), 0, 1, self.frame.size.height)];
        _rightLineView.backgroundColor = RGBAColor(240, 240, 240, 1);
    }
    return _rightLineView;
}

-(UIButton *)rightBtn{
    if (_rightBtn == nil) {
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(CGRectGetMaxX(_rightLineView.frame), 0, self.frame.size.width * 2/7 - 1, self.frame.size.height);
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"shopCar_plus"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(plusBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

#pragma mark -- UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.CountBlock) {
        self.CountBlock([textField.text floatValue]);
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.countTF resignFirstResponder];
    return YES;
}

#pragma mark -- 按钮响应事件
- (void)cutBtnClicked{//减少
    [self.countTF resignFirstResponder];
    NSInteger count = [self.countTF.text integerValue] - 1;
    if (count <= 0) {
        return;
    }
    if (count == 1) {
        [self.leftBtn setImage:[UIImage imageNamed:@"shopCar_cutend"] forState:UIControlStateNormal];
    }
    self.countTF.text = [NSString stringWithFormat:@"%zd", count];
    if (self.CountBlock) {
        self.CountBlock(count);
    }
}

- (void)plusBtnClicked{//增加
    [self.countTF resignFirstResponder];
    NSInteger count = [self.countTF.text integerValue] + 1;
    if (count>_goodstock) {
//        [MBProgressHUD showNote:@"超额了"];
        return;
    }
    self.countTF.text = [NSString stringWithFormat:@"%zd", count];
    [self.leftBtn setImage:[UIImage imageNamed:@"shopCar_cut"] forState:UIControlStateNormal];
    if (self.CountBlock) {
        self.CountBlock(count);
    }

   }

#pragma mark ----

-(void)setCount:(NSInteger)count{
    _count = count;
    self.countTF.text = [NSString stringWithFormat:@"%zd", _count];
    if (count == 1) {
        [self.leftBtn setImage:[UIImage imageNamed:@"shopCar_cutend"] forState:UIControlStateNormal];
    }else{
        [self.leftBtn setImage:[UIImage imageNamed:@"shopCar_cut"] forState:UIControlStateNormal];
    }
}



@end
