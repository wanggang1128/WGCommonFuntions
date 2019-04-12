//
//  HuCusSagmentBtnView.m
//  HuTrainKit
//
//  Created by wanggang on 2019/3/26.
//

#define DefaultTagTextColor_normal [UIColor blackColor]
#define DefaultTagTextColor_selected [UIColor redColor]
#define DefaultTagTextFont_normal 15
#define DefaultTagTextFont_selected 22
#define DefaultSliderColor [UIColor redColor]
#define DefaultSliderH 1
#define DefaultSliderW 30

#import "HuCusSagmentBtnView.h"
#import "UIView+WGFrame.h"

@interface HuCusSagmentBtnView()

@property (nonatomic, strong) NSMutableArray * buttonsArray;
@property (nonatomic, strong) UIView * sliderView;

@end

@implementation HuCusSagmentBtnView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        _buttonsArray = [[NSMutableArray alloc] init];
        
        //默认
        _tagTextColor_normal = DefaultTagTextColor_normal;
        _tagTextColor_selected = DefaultTagTextColor_selected;
        _tagTextFont_normal = DefaultTagTextFont_normal;
        _tagTextFont_selected = DefaultTagTextFont_selected;
        _sliderColor = DefaultSliderColor;
        _sliderH = DefaultSliderH;
        _sliderW = DefaultSliderW;
        
    }
    return self;
}

- (void)createUI
{
    [self.buttonsArray removeAllObjects];
    float width = self.width / _dataArr.count;
    
    for (int i = 0 ; i < _dataArr.count ; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 0, width, self.height)];
        button.tag = 1000+i;
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:[_dataArr objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:self.tagTextColor_normal forState:UIControlStateNormal];
        [button setTitleColor:self.tagTextColor_selected forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_normal];
        [button addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //默认第一个选中
        if (i == 0) {
            button.selected = YES;
            button.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_selected];
        }
        
        [self.buttonsArray addObject:button];
        [self addSubview:button];
    }
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-self.sliderH, self.sliderW, self.sliderH)];
    self.sliderView.centerX = width/2;
    self.sliderView.backgroundColor = self.sliderColor;
    [self addSubview:self.sliderView];
}

- (void)tagBtnClick:(UIButton *)btn
{
    [UIView animateWithDuration:0.2 animations:^{
        self.sliderView.centerX = btn.centerX;
    }];
    
    for (UIButton *subButton in self.buttonsArray) {
        subButton.selected = NO;
        subButton.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_normal];
    }
    btn.selected = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_selected];
    
    if ([self.huCusSagmentBtnViewDelegate respondsToSelector:@selector(didTapBtnWithIndex:)]) {
        [self.huCusSagmentBtnViewDelegate didTapBtnWithIndex:btn.tag -1000];
    }
}

//滑动视图滑动到某个index
- (void)slidBtnWithIndex:(NSInteger)index{
    
    NSInteger s_btnTagIndex = index+1000;
    for (UIButton *subButton in self.buttonsArray) {
        if (s_btnTagIndex != subButton.tag) {
            subButton.selected = NO;
            subButton.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_normal];
        }
        else{
            [UIView animateWithDuration:0.2 animations:^{
                self.sliderView.centerX = subButton.centerX;
            } completion:^(BOOL finished) {
                subButton.selected = YES;
                subButton.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_selected];
            }];
        }
    }
}

- (void)setDataArr:(NSArray *)dataArr
{
    if (_dataArr != dataArr) {
        _dataArr = dataArr;
        [self createUI];
    }
}

-(void)setTitleArrNew:(NSArray *)titleArrNew{
    
    _titleArrNew = titleArrNew;
    if (titleArrNew.count == _dataArr.count) {
        
        for (int i = 0; i<titleArrNew.count; i++) {
            UIButton *btn = (UIButton *)[self viewWithTag:(1000+i)];
            [btn setTitle:titleArrNew[i] forState:UIControlStateNormal];
        }
    }
}

- (void)setTagTextColor_normal:(UIColor *)tagTextColor_normal
{
    if (_tagTextColor_normal != tagTextColor_normal) {
        for (UIButton *subButton in self.buttonsArray){
            [subButton setTitleColor:tagTextColor_normal forState:UIControlStateNormal];
        }
        _tagTextColor_normal = tagTextColor_normal;
    }
}
- (void)setTagTextColor_selected:(UIColor *)tagTextColor_selected
{
    if (_tagTextColor_selected != tagTextColor_selected) {
        for (UIButton *subButton in self.buttonsArray){
            [subButton setTitleColor:tagTextColor_selected forState:UIControlStateSelected];
        }
        _tagTextColor_selected = tagTextColor_selected;
    }
}
- (void)setTagTextFont_normal:(CGFloat)tagTextFont_normal
{
    if (_tagTextFont_normal != tagTextFont_normal) {
        for (UIButton *subButton in self.buttonsArray){
            if (subButton.selected == NO) {
                subButton.titleLabel.font = [UIFont systemFontOfSize:tagTextFont_normal] ;
            }
        }
        _tagTextFont_normal = tagTextFont_normal;
    }
}
- (void)setTagTextFont_selected:(CGFloat)tagTextFont_selected
{
    if (_tagTextFont_selected != tagTextFont_selected) {
        for (UIButton *subButton in self.buttonsArray){
            if (subButton.selected == YES) {
                subButton.titleLabel.font = [UIFont systemFontOfSize:tagTextFont_selected] ;
            }
        }
        _tagTextFont_selected = tagTextFont_selected;
    }
}
- (void)setSliderColor:(UIColor *)sliderColor
{
    if (_sliderColor != sliderColor) {
        self.sliderView.backgroundColor = sliderColor;
        _sliderColor = sliderColor;
    }
}
- (void)setSliderW:(CGFloat)sliderW
{
    if (_sliderW != sliderW) {
        self.sliderView.width = sliderW;
        _sliderW = sliderW;
    }
}
- (void)setSliderH:(CGFloat)sliderH
{
    if (_sliderH != sliderH) {
        self.sliderView.height = sliderH;
        self.sliderView.y = self.height-self.sliderView.height;
        for (UIButton *subButton in self.buttonsArray){
            if (subButton.selected == YES) {
                self.sliderView.centerX = subButton.centerX;
            }
        }
        _sliderH = sliderH;
    }
}

@end
