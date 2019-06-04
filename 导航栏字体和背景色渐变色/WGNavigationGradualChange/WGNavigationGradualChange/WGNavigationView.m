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

@interface WGNavigationView()

//是否返回自己作为最合适view(通俗讲就是点击自己时自己是否处理)
@property (nonatomic, assign) BOOL best;

@end

@implementation WGNavigationView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildView];
    }
    return self;
}

- (void)buildView{
    self.backgroundColor = UIColor.blackColor;
    [self addSubview:self.backBtn];
    [self addSubview:self.actionBtn];
    [self addSubview:self.titleLab];
}


- (void)startAni:(CGFloat)offset{
    
    CGFloat alpha = (offset+20)/300.0;
    alpha = alpha>1?1:(alpha);
    self.alpha = alpha;
    self.backBtn.alpha = alpha;
    self.actionBtn.alpha = alpha;
    if ((offset)>=300) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
        [self.backBtn setBackgroundImage:[UIImage imageNamed:@"nursing_selected"] forState:0];
        [self.actionBtn setBackgroundImage:[UIImage imageNamed:@"consultation_selected"] forState:0];
        self.titleLab.textColor = UIColor.whiteColor;
        self.best = alpha>0.05;
        
    }else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
        [self.backBtn setBackgroundImage:[UIImage imageNamed:@"nursing_normal"] forState:0];
        [self.actionBtn setBackgroundImage:[UIImage imageNamed:@"consultation_normal"] forState:0];
        self.titleLab.textColor = UIColor.blackColor;
        self.best = alpha>0.05;
    }
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
        _backBtn.frame =CGRectMake(11, (self.frame.size.height -30+20)/2, 30, 30);
        _backBtn.layer.masksToBounds = YES;
        _backBtn.layer.cornerRadius = _backBtn.frame.size.width/2;
        [_backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

-(UIButton *)actionBtn{
    if (!_actionBtn) {
        _actionBtn = [[UIButton alloc] init];
        _actionBtn.frame = CGRectMake(self.frame.size.width-41, (self.frame.size.height -30+20)/2,30,30);
        _actionBtn.layer.masksToBounds = YES;
        _actionBtn.layer.cornerRadius = _backBtn.frame.size.width/2;
        [_actionBtn setBackgroundImage:[UIImage imageNamed:@"consultation_normal"] forState:UIControlStateNormal];
        [_actionBtn addTarget:self action:@selector(actionBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(50, (self.frame.size.height -30+20)/2, (self.frame.size.width-100), 30)];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:22];
    }
    return _titleLab;
}

//在点击self的时候不响应事件
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if (self.best) {
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

@end
