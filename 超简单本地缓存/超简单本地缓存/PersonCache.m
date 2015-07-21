//
//  PerpleCache.m
//  超简单本地缓存
//
//  Created by 葬花桥 on 15/7/21.
//  Copyright (c) 2015年 mmedi.cn. All rights reserved.
//

#import "PersonCache.h"

@implementation PersonCache
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dog = [[DogCache alloc] init];
        _book = [[BookCache alloc] init];
    }
    return self;
}
@end
