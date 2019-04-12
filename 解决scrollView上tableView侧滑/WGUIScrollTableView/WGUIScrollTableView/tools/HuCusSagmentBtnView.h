//
//  HuCusSagmentBtnView.h
//  HuTrainKit
//
//  Created by wanggang on 2019/3/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HuCusSagmentBtnViewDelegate <NSObject>

@optional


/**
 点击某个滑动按钮

 @param index 滑动按钮位置
 */
- (void) didTapBtnWithIndex:(NSInteger)index;

@end

@interface HuCusSagmentBtnView : UIView

//标签数据源数组
@property (nonatomic, strong) NSArray * dataArr;

//更新标签标题数组
@property (nonatomic, strong) NSArray * titleArrNew;

//未选中时:标签字体颜色
@property (nonatomic, strong) UIColor * tagTextColor_normal;

//选中时:标签字体颜色
@property (nonatomic, strong) UIColor * tagTextColor_selected;

//未选中时:标签字体大小
@property (nonatomic, assign)CGFloat tagTextFont_normal;

//选中时:标签字体大小
@property (nonatomic, assign)CGFloat tagTextFont_selected;

//滑动条颜色
@property (nonatomic, strong)UIColor *sliderColor;

//滑动条h宽度
@property (nonatomic, assign)CGFloat sliderW;

//滑动条高度
@property (nonatomic, assign)CGFloat sliderH;

@property (nonatomic, weak) id<HuCusSagmentBtnViewDelegate>huCusSagmentBtnViewDelegate;

//滑动视图滑动到某个index
- (void)slidBtnWithIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
