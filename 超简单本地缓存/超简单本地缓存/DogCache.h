//
//  DogCache.h
//  超简单本地缓存
//
//  Created by 葬花桥 on 15/7/21.
//  Copyright (c) 2015年 mmedi.cn. All rights reserved.
//

#import "QiaoArchiveBaseModel.h"

@interface DogCache : QiaoArchiveBaseModel
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *dogType;
@end
