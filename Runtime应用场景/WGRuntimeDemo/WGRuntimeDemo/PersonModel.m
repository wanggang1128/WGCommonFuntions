//
//  PersonModel.m
//  WGRuntimeDemo
//
//  Created by wanggang on 2018/4/17.
//  Copyright © 2018年 wanggang. All rights reserved.
//

//这个类用来了解下runtime实现字典和Model互转。
//字典转模型：思路就是每个属性都有对应的set方法，这里根据字典中对应KEY生成对应的set方法，然后向对象发送消息。
//模型转字典：遍历所有属性，然后根据属性名称生成对应get方法，向对象发送消息。

#import "PersonModel.h"
#import <objc/message.h>

@implementation PersonModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self=[super init]) {
        NSArray *keyArr = [dictionary allKeys];
        for (int i = 0; i<keyArr.count; i++) {
            NSString *key = keyArr[i];
            id value = [dictionary valueForKey:key];
            //key首字母大写
            NSString *setName = [NSString stringWithFormat:@"set%@:",key.capitalizedString];
            //生成set方法
            SEL method = NSSelectorFromString(setName);
            if ([self respondsToSelector:method]) {
                objc_msgSend(self, method, value);
            }else{
                NSLog(@"生成%@set方法失败", key.capitalizedString);
            }
        }
    }
    return self;
}

-(NSDictionary *)convertToDictionary{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    if (count >0) {
        for (int i=0; i<count; i++) {
            objc_property_t property = properties[i];
            const char *pro = property_getName(property);
            NSString *proName = [NSString stringWithUTF8String:pro];
            SEL method = NSSelectorFromString(proName);
            if ([self respondsToSelector:method]) {
                id value = objc_msgSend(self, method);
                if (value) {
                    [dic setValue:value forKey:proName];
                }else{
                    [dic setValue:@"字典的key对应的value不能为nil哦!" forKey:proName];
                }
            }
        }
        free(properties);
        return dic;
    }
    free(properties);
    return nil;
}

@end
