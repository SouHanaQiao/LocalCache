//
//  QiaoArchiveBaseModel.h
//  MDTDoctor
//
//  Created by 葬花桥 on 15/7/19.
//  Copyright (c) 2015年 mmedi.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QiaoArchiveBaseModel : NSObject

/*!
 *  @author 葬花桥, 15-07-19 15:07:43
 *
 *  创建一个默认文件路径的归档对象
 *
 *  @return 创建的对象
 */
+ (id)createObjectFromFile;

/*!
 *  @author 葬花桥, 15-07-19 15:07:13
 *
 *  创建自定义路径下的归档对象
 *
 *  @param archiveFilePath 文件路径, 结束字符不需要加 "/"
 *  @param archiveFileName 文件名
 *
 *  @return 对象
 */
+ (id)createObjectFromFileWithArchiveFilePath:(NSString *)archiveFilePath fileName:(NSString *)archiveFileName;

/*!
 *  @author 葬花桥, 15-07-19 15:07:27
 *
 *  将归档写入文件, 如果不做此操作, 本地文件不会有改变
 */
- (void)writeToFile;

- (id)initWithCoder:(NSCoder *)aDecoder;

@end
