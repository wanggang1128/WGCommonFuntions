//
//  CPerson+Associate.h
//  WGRuntimeDemo
//
//  Created by wanggang on 2018/4/17.
//  Copyright © 2018年 wanggang. All rights reserved.
//

#import "CPerson.h"

typedef void(^CodingCallback)(void);

@interface CPerson (Associate)

@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, copy) CodingCallback associatedCallback;

@end
