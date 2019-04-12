//
//  ViewController.m
//  WGSliderSensitivityDemo
//
//  Created by wanggang on 2019/4/12.
//  Copyright © 2019 bozhong. All rights reserved.
//

#define WGWIDTH [UIScreen mainScreen].bounds.size.width
#define WGHEIGHT [UIScreen mainScreen].bounds.size.height


#import "ViewController.h"
#import "WGUISlider.h"

@interface ViewController ()

@property (nonatomic, strong) WGUISlider *slideView;
@property (nonatomic, strong) UILabel *curValueLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.slideView];
    [self.view addSubview:self.curValueLab];
}

- (void)slideViewChange:(UISlider *)sender{
    
    self.curValueLab.text = [NSString stringWithFormat:@"当前进度:%.2f",sender.value];
    
}

- (WGUISlider *)slideView{
    
    if (!_slideView) {
        _slideView = [[WGUISlider alloc] initWithFrame:CGRectMake(WGWIDTH/3/2, WGHEIGHT-50, WGWIDTH*2/3, 5)];
        [_slideView addTarget:self action:@selector(slideViewChange:) forControlEvents:UIControlEventValueChanged];
        _slideView.minimumValue = 0;
        _slideView.maximumValue = 1;
        _slideView.value = 0.5;
        _slideView.thumbTintColor = [UIColor cyanColor];
    }
    return _slideView;
}

- (UILabel *)curValueLab{
    
    if (!_curValueLab) {
        _curValueLab = [[UILabel alloc] initWithFrame:CGRectMake(WGWIDTH/3/2, WGHEIGHT-50-40, WGWIDTH*2/3, 20)];
        _curValueLab.textAlignment = NSTextAlignmentCenter;
        _curValueLab.textColor = [UIColor blackColor];
        _curValueLab.text = [NSString stringWithFormat:@"当前进度:%.2f",_slideView.value];
    }
    return _curValueLab;
}

@end
