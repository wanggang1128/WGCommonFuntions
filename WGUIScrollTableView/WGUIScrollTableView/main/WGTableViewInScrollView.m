//
//  WGTableViewInScrollView.m
//  WGUIScrollTableView
//
//  Created by wanggang on 2019/4/11.
//  Copyright © 2019 bozhong. All rights reserved.
//

#import "WGTableViewInScrollView.h"

@implementation WGTableViewInScrollView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView *resultView = [super hitTest:point withEvent:event];
    if (resultView) {
        /*
         resultView为nil说明不再在view上,不作处理
         不为nil,则进行下面处理
         */
        if (resultView != self) {
            
            /*
             如果响应resultView不是UIScrollView,则根据用户滑动位置来确定
             是self的子视图(tableView)侧滑
             还是self本身(scrollView)滚动
             */
            int count =  (int)point.x / (int)([UIScreen mainScreen].bounds.size.width);
            CGFloat res = point.x - ([UIScreen mainScreen].bounds.size.width)*count;
            if (res > ([UIScreen mainScreen].bounds.size.width - 100)) {
                
                //在屏幕右边缘(100以内,自己可根据情况修改)位置,则认为是tableView侧滑
                self.scrollEnabled = NO;
                //这里只是暂时设置self不可滑动,但是最佳响应这并没有改变
                return resultView;
            }else{
                
                //在屏幕左侧或者中间位置,则认为是self滚动
                self.scrollEnabled = YES;
                return resultView;
            }
            
        }else{
            //如果self是,则恢复滑动
            self.scrollEnabled = YES;
            return resultView;
        }
    }else{
        return nil;
    }
}

@end
