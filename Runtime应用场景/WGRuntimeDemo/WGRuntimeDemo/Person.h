//
//  Person.h
//  WGRuntimeDemo
//
//  Created by wanggang on 2018/4/17.
//  Copyright © 2018年 wanggang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>

//下面四个属性用来归解档
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, copy) NSString *school;
@property (nonatomic, assign) int height;

- (NSString *)msgsendTest:(NSString *)str;

@end
