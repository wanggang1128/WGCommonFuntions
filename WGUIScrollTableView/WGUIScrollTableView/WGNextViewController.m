//
//  WGNextViewController.m
//  WGUIScrollTableView
//
//  Created by wanggang on 2019/4/11.
//  Copyright © 2019 bozhong. All rights reserved.
//

#import "WGNextViewController.h"

@interface WGNextViewController ()

@end

@implementation WGNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"下一页";
    
    if (self.type == 0) {
        self.view.backgroundColor = [UIColor cyanColor];
    }else{
        self.view.backgroundColor = [UIColor yellowColor];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
