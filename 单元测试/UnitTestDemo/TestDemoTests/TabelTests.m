//
//  TabelTests.m
//  TestDemo
//
//  Created by 李勇 on 2016/12/29.
//  Copyright © 2016年 aoke. All rights reserved.
//

#import "TabelTests.h"
#import "ViewController+UnitTest.h"
@implementation TabelTests

/**
 *  每个test方法执行之前调用
 *
 */
- (void)setUp {
    [super setUp];
    //定义
    self.VC = [[ViewController alloc] init];
}

/**
 *  每个test方法执行之后调用,释放测试用例的资源代码，这个方法会每个测试用例执行后调用
 */
- (void)tearDown {
    
    //结束后释放
    self.VC = nil;
    
    [super tearDown];
}


//测试table数据源函数返回行数
- (void)testControllerReturnsCorrectNumberOfRows
{
    XCTAssertEqual(3, [self.VC tableView:self.VC.tableView numberOfRowsInSection:0],@"此处返回得到的行数错误");
}

//测试table数据源函数返回cell
- (void)testControllerSetsUpCellCorrectly
{
    id mockTable = OCMClassMock([UITableView class]);
    [[[mockTable expect] andReturn:nil] dequeueReusableCellWithIdentifier:@"HappyNewYear"];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    
    UITableViewCell *cell = [self.VC tableView:mockTable cellForRowAtIndexPath:indexPath];
    
    XCTAssertNotNil(cell, @"此处应该返回一个cell");
    XCTAssertEqualObjects(@"x-2", cell.textLabel.text, @"返回的字符串错误");
    
    [mockTable verify];
}

//访问被测试类的私有方法（写一个被测试类的category或着被测试类的子类，声明私有方法，不需要实现）
-(void)testAdd{
    
    NSInteger num = 100;
    
    XCTAssertEqual(num, [self.VC addA:30 b:70],@"不相等");
}

@end
