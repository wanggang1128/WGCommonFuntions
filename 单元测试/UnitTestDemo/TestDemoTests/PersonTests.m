//
//  PersonTests.m
//  TestDemo
//
//  Created by 李勇 on 2016/12/29.
//  Copyright © 2016年 aoke. All rights reserved.
//

#import "TestDemoCase.h"
#import "PersonModel.h"
#import <OCMock/OCMock.h>

@interface PersonTests : TestDemoCase

@end


@implementation PersonTests
/**
 *  每个test方法执行之前调用
 *
 */
- (void)setUp {
    [super setUp];


}

/**
 *  每个test方法执行之后调用,释放测试用例的资源代码，这个方法会每个测试用例执行后调用
 */
- (void)tearDown {
    
    //结束后释放
    
    [super tearDown];
}


//没有参数的方法
- (void)testGetName{
    PersonModel *person = [[PersonModel alloc] init];
    
    //创建一个mock对象
    id mockClass = OCMClassMock([PersonModel class]);
    //可以给这个mock对象的方法设置预设的参数和返回值
    OCMStub([mockClass getPersonName]).andReturn(@"liyong");
    
    //用这个预设的值和实际的值进行比较是否相等
    XCTAssertEqualObjects([mockClass getPersonName], [person getPersonName], @"值相等");
    

}
//有参数的方法
- (void)testCahngeName{
    
    PersonModel *person = [[PersonModel alloc] init];
    
    id mockClass = OCMClassMock([PersonModel class]);
    //[OCMArg any]是指任意参数,下面调用方法时传的参数必须与此处的参数一样才会返回设定的值
    OCMStub([mockClass changeName:[OCMArg any]]).andReturn(@"wss");
    
    //验证getPersonName方法有没有被调用，如果没有调用则抛出异常
//    OCMVerify([mockClass getPersonName]);
    
    XCTAssertEqualObjects([mockClass changeName:[OCMArg any]], [person changeName:@"wss"],@"值相等");
}

//检查参数
- (void)testArgument{
    id mockClass = OCMClassMock([PersonModel class]);
    //检查参数
    OCMStub([mockClass changeName:[OCMArg checkWithBlock:^BOOL(id obj) {
        //判断参数是否为NSString类型
        if ([obj isKindOfClass:[NSString class]]){
        }else{
            //提示错误
//            XCTAssertFalse(obj);
            
            obj = @"456";
        }
        NSLog(@"-----------------%@",obj);
        return YES;
    }]]);
    
    [mockClass changeName:@"123"];
    [mockClass changeName:[OCMArg any]];
}

@end
