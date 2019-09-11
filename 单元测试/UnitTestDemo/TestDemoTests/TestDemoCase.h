//
//  TestDemoCase.h
//  TestDemo
//
//  Created by wangshanshan on 17/1/4.
//  Copyright © 2017年 aoke. All rights reserved.
//测试类的基类，所有的测试类需要继承该类

#import <XCTest/XCTest.h>

@interface TestDemoCase : XCTestCase

@property (nonatomic, assign) NSTimeInterval networkTimeout;

- (void)waitForExpectationsWithCommonTimeout;
- (void)waitForExpectationsWithCommonTimeoutUsingHandler:(XCWaitCompletionHandler)handler;


@end
