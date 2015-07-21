//
//  BookCache.h
//  超简单本地缓存
//
//  Created by 葬花桥 on 15/7/21.
//  Copyright (c) 2015年 mmedi.cn. All rights reserved.
//

#import "QiaoArchiveBaseModel.h"

@interface BookCache : QiaoArchiveBaseModel
@property (nonatomic, strong) NSString *bookName;
@property (nonatomic, assign) float price;
@end
