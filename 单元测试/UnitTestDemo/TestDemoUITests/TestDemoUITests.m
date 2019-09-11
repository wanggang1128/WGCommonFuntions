//
//  TestDemoUITests.m
//  TestDemoUITests
//
//  Created by 李勇 on 2016/12/29.
//  Copyright © 2016年 aoke. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface TestDemoUITests : XCTestCase

@end

@implementation TestDemoUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

//检测登录
- (void)testLogin{
    
    //首先从tabbars找到“登录”然后点击
    [[[XCUIApplication alloc] init].tabBars.buttons[@"登录"] tap];
    //获取app
    XCUIApplication *app = [[XCUIApplication alloc] init];
    //在当前页面寻找与“accountTF”有关系的输入框，我测试时发现placeholder写为“accountTF”就可以寻找到
    XCUIElement *textField = app.textFields[@"accountTF"];
    [textField tap];//获取焦点成为第一响应者，否则会报“元素（此textField）未调起键盘”错误
    [textField typeText:@"liyong"];//为此textField键入字符串
    
    XCUIElement *textField2 = app.textFields[@"passwordTF"];
    [textField2 tap];
    [textField2 typeText:@"123456"];
    
    for (int i = 0; i < 20; i ++) {//n次点击登陆按钮
        [app.buttons[@"login"] tap];//login标示的button点击
    }
    
    //如果页面title为success则表示登录成功，也可用其他判断方式
    XCTAssertEqualObjects(app.navigationBars.element.identifier, @"success");
}

//列表下拉以及上拉测试
- (void)testRefresh{
    //获取app
    XCUIApplication *app = [[XCUIApplication alloc] init];
    //点击tabbar中“列表”这个
    [app.tabBars.buttons[@"列表"] tap];
    //获取当前页面的tabble（此页面只有一个table，代码自动生成的）
    XCUIElement *table = [[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeTable].element;
    
    //可通过循环上拉或者下拉无数次
    [table swipeDown];//下拉
    [table swipeUp];//上拉
}

//tablecell点击以及返回
- (void)testCellClick{
    //获取app
    XCUIApplication *app = [[XCUIApplication alloc] init];
    //点击tabbar中“列表”这个
    [app.tabBars.buttons[@"列表"] tap];
    //在当前页面获取table的cell队列
    XCUIElementQuery *tablesQuery = app.tables;
    //点击了第一个cell，此cell有一个标示为“x-x”
    [[[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:0].staticTexts[@"x-x"] tap];
    //在“login”为title的页面中点击了导航栏中“table”按钮---login页面为点击cell进入的页面，table是导航栏左侧按钮，点击返回列表页面
    XCUIElement *tableButton = app.navigationBars[@"login"].buttons[@"table"];
    [tableButton tap];//点击返回
    
    [[[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:7].staticTexts[@"x-x"] tap];
    [tableButton tap];
    [[[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:9].staticTexts[@"x-x"] tap];
    //点击login页面中“back”按钮返回，
    [app.buttons[@"back"] tap];
    
    /**
     *在执行过程中如果只进行多次通过点击back来返回则可以使用
     *XCUIElement *backButton = app.buttons[@"back"];
     *后面直接用
     *[backButton tap];
     
     例如：
     
     XCUIElement *xXStaticText = [[app.tables childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:0].staticTexts[@"x-x"];
     [xXStaticText tap];
     XCUIElement *backButton = app.buttons[@"back"];
     [backButton tap];
     [xXStaticText tap];
     [backButton tap];
     [xXStaticText tap];
     [backButton tap];
     [xXStaticText tap];
     [backButton tap];
     [xXStaticText tap];
     [backButton tap];
     [xXStaticText tap];
     [backButton tap];
     */

}


@end
