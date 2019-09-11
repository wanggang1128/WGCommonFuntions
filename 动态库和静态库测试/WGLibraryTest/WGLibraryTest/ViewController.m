//
//  ViewController.m
//  WGLibraryTest
//
//  Created by wanggang on 2019/8/15.
//  Copyright © 2019 wg. All rights reserved.
//

#import "ViewController.h"
#import "WGStaticA.h"
#import <WGStaticLibrary/WGStaticLibrary.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WGStaticA *sta = [[WGStaticA alloc] init];
    [sta staticAMethod];
    
    WGPerson *per = [WGPerson new];
    [per staticLibrary];
    
}



@end
