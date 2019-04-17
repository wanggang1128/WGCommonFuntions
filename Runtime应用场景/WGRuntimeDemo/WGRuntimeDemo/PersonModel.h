//
//  PersonModel.h
//  WGRuntimeDemo
//
//  Created by wanggang on 2018/4/17.
//  Copyright © 2018年 wanggang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, copy) NSString *occupation;
@property (nonatomic, copy) NSString *captionality;

//字典转模型
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
//模型转字典
- (NSDictionary *)convertToDictionary;

@end
