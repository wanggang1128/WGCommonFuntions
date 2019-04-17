//
//  CPerson.h
//  WGRuntimeDemo
//
//  Created by wanggang on 2018/4/17.
//  Copyright © 2018年 wanggang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPerson : NSObject{
    NSString *_occupation;//职业
    NSString *_nationality;//国籍
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger age;

- (NSDictionary *)allProperties;
- (NSDictionary *)allIvars;
- (NSDictionary *)allMethods;

@end
