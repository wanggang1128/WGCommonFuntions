//
//  NSObject+WG_KVO.h
//  WGRuntimeDemo
//
//  Created by wanggang on 2019/9/20.
//  Copyright © 2019 wanggang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (WG_KVO)

-(void)wg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;

-(void)wg_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context;
@end

NS_ASSUME_NONNULL_END
