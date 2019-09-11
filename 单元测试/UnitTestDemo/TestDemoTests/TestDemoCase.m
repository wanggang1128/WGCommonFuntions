//
//  TestDemoCase.m
//  TestDemo
//
//  Created by wangshanshan on 17/1/4.
//  Copyright © 2017年 aoke. All rights reserved.
//

#import "TestDemoCase.h"


@implementation TestDemoCase

- (void)setUp {
    [super setUp];
    self.networkTimeout = 10.0;
}

- (void)tearDown {
    [super tearDown];
}


- (void)waitForExpectationsWithCommonTimeout {
    [self waitForExpectationsWithCommonTimeoutUsingHandler:nil];
}

- (void)waitForExpectationsWithCommonTimeoutUsingHandler:(XCWaitCompletionHandler)handler {
    [self waitForExpectationsWithTimeout:self.networkTimeout handler:handler];
}

@end
