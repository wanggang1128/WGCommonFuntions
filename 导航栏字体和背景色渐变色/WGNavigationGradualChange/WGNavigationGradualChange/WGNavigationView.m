//
//  WGNavigationView.m
//  WGNavigationGradualChange
//
//  Created by wanggang on 2018/7/31.
//  Copyright © 2018年 wanggang. All rights reserved.
//

#define SCREEN_HEIGHT [ UIScreen mainScreen ].bounds.size.height
#define SCREEN_WIDTH  [ UIScreen mainScreen ].bounds.size.width

#import "WGNavigationView.h"

@implementation WGNavigationView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildView];
        [self addNotification];
    }
    return self;
}

- (void)buildView{
    [self addSubview:self.backBtn];
    [self addSubview:self.actionBtn];
    
    CAGradientLayer * layer = [[CAGradientLayer alloc] init];
    layer.frame = self.bounds;
    layer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.2].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.15].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.1].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.05].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.03].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.01].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.0].CGColor];
    [self.layer addSublayer:layer];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _backBtn.frame =CGRectMake(11, self.frame.size.height -35, 30, 30);
    _backBtn.layer.masksToBounds = YES;
    _backBtn.layer.cornerRadius = _backBtn.frame.size.width/2;
    
    _actionBtn.frame = CGRectMake(self.frame.size.width-41, self.frame.size.height - 35,30,30);
    _actionBtn.layer.masksToBounds = YES;
    _actionBtn.layer.cornerRadius = _backBtn.frame.size.width/2;
}

- (void)addNotification{
    __weak __typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter]addObserverForName:@"SHOWNAVIGATIONVIEW" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf.backBtn setBackgroundImage:[UIImage imageNamed:@"nursing_selected"] forState:0];
        [weakSelf.actionBtn setBackgroundImage:[UIImage imageNamed:@"consultation_selected"] forState:0];
        weakSelf.alp = note.object;
    }];
    
    [[NSNotificationCenter defaultCenter]addObserverForName:@"HIDENNAVIGATIONVIEW" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf.backBtn setBackgroundImage:[UIImage imageNamed:@"nursing_normal"] forState:0];
        [weakSelf.actionBtn setBackgroundImage:[UIImage imageNamed:@"consultation_normal"] forState:0];
        weakSelf.alp = note.object;
    }];
}

- (void)backBtnClicked{
    if (self.wgNavigationViewDelegate && [self.wgNavigationViewDelegate respondsToSelector:@selector(backBtnMethod)]) {
        [self.wgNavigationViewDelegate backBtnMethod];
    }
}

- (void)actionBtnClicked{
    if (self.wgNavigationViewDelegate && [self.wgNavigationViewDelegate respondsToSelector:@selector(actionBtnMethod)]) {
        [self.wgNavigationViewDelegate actionBtnMethod];
    }
}

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"nursing_normal"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

-(UIButton *)actionBtn{
    if (!_actionBtn) {
        _actionBtn = [[UIButton alloc] init];
        [_actionBtn setBackgroundImage:[UIImage imageNamed:@"consultation_normal"] forState:UIControlStateNormal];
        [_actionBtn addTarget:self action:@selector(actionBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionBtn;
}

//在点击self的时候不响应事件
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if ([self.alp isEqualToString:@"NO"]) {
        return view;
    }else{
        if (view == self) {
            return nil;
        }else{
            return view;
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"我是自定义导航栏,要实现自己的方法了");
    /*
     1.放开下面一句代码的话,会把这个事件向上传递,达到一个事件多个对象处理
     2.注释掉的话,事件就只会在这里处理
     */
//    [super touchesBegan:touches withEvent:event];
}

-(void)dealloc{
    NSLog(@"所有通知被移除");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
