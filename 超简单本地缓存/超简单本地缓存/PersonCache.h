//
//  PerpleCache.h
//  超简单本地缓存
//
//  Created by 葬花桥 on 15/7/21.
//  Copyright (c) 2015年 mmedi.cn. All rights reserved.
//

#import "QiaoArchiveBaseModel.h"
#import "DogCache.h"
#import "BookCache.h"

@interface PersonCache : QiaoArchiveBaseModel
@property (nonatomic, strong) BookCache *book;
@property (nonatomic, strong) DogCache *dog;
@end
