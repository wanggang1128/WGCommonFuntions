//
//  PersonModel.m
//  TestDemo
//
//  Created by 李勇 on 2016/12/29.
//  Copyright © 2016年 aoke. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel

- (instancetype)init{
    if (self = [super init]){
        self.name = @"liyong";
        self.gender = @"男";
    }
    return self;
}

- (NSString *)getPersonName{
    PersonModel *person = [[PersonModel alloc] init];
    return person.name;
}

- (NSString *)changeName:(NSString *)newName{
    PersonModel *person = [[PersonModel alloc] init];
    person.name = newName;
    
    return person.name;
}


@end
