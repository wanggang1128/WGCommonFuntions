//
//  WGNavigationView.h
//  WGNavigationGradualChange
//
//  Created by wanggang on 2018/7/31.
//  Copyright © 2018年 wanggang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol WGNavigationViewDelegate <NSObject>

//点击返回
- (void)backBtnMethod;
//功能按钮点击
- (void)actionBtnMethod;

@end

@interface WGNavigationView : UIView

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *actionBtn;
//是否返回自己作为最合适view(通俗讲就是点击自己时自己是否处理)
@property (nonatomic, copy) NSString *alp;

@property (nonatomic, weak) id<WGNavigationViewDelegate>wgNavigationViewDelegate;

@end
