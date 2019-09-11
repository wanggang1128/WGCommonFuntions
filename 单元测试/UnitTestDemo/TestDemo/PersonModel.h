//
//  PersonModel.h
//  TestDemo
//
//  Created by 李勇 on 2016/12/29.
//  Copyright © 2016年 aoke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *gender;


- (NSString *)getPersonName;

- (NSString *)changeName:(NSString *)newName;


@end
