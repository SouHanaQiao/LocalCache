//
//  QiaoArchiveBaseModel.m
//  MDTDoctor
//
//  Created by 葬花桥 on 15/7/19.
//  Copyright (c) 2015年 mmedi.cn. All rights reserved.
//

#import "QiaoArchiveBaseModel.h"
#import <objc/runtime.h>

#define CachQiaoDirectory @"/ArchiveFiles"

@interface QiaoArchiveBaseModel () <NSCoding>
//@property (nonatomic, copy) NSString *archiveFilePath; //! 归档的文件路径 .... 为空则为documents/ArchiveFiles
@property (nonatomic, copy) NSString *archiveFileName; //! 归档的文件名 为空则使用类名
@end

@implementation QiaoArchiveBaseModel

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
//        _archiveFilePath = [aDecoder decodeObjectForKey:@"archiveFilePath"];
//        _archiveFileName = [aDecoder decodeObjectForKey:@"archiveFileName"];
        u_int count;
        objc_property_t *properties  = class_copyPropertyList([self class], &count);
        for (int i = 0; i<count; i++)
        {
            const char* propertyName = property_getName(properties[i]);
            //        const char* type = property_getAttributes(properties[i]);
            NSString *key = [NSString stringWithUTF8String:propertyName];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(properties);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
//    [aCoder encodeObject:_archiveFilePath forKey:@"archiveFilePath"];
//    [aCoder encodeObject:_archiveFileName forKey:@"archiveFileName"];
    
    u_int count;
    objc_property_t *properties  = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++)
    {
        const char* propertyName = property_getName(properties[i]);
//                const char* type = property_getAttributes(properties[i]);
        NSString *key = [NSString stringWithUTF8String:propertyName];
//        NSString *propertyType = [NSString stringWithUTF8String:type];
        id value = [self valueForKey:key];
        
        [aCoder encodeObject:value forKey:key];
    }
    free(properties);
}

+ (id)createObjectFromFile
{
    return [self createObjectFromFileWithArchiveFilePath:nil fileName:nil];
}

+ (id)createObjectFromFileWithArchiveFilePath:(NSString *)archiveFilePath fileName:(NSString *)archiveFileName
{
    NSString *writeToFilePath = archiveFilePath;
    if (writeToFilePath == nil || writeToFilePath.length == 0) {
        writeToFilePath = [[self filePath] stringByAppendingString:CachQiaoDirectory];
    }
    
    writeToFilePath = [writeToFilePath stringByAppendingString:@"/"];
    
    NSString *fileName = archiveFileName;
    if (fileName == nil || fileName.length == 0) {
        fileName = NSStringFromClass([self class]);
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [NSString stringWithFormat:@"%@%@", writeToFilePath, fileName];
    BOOL exist = [fileManager fileExistsAtPath:filePath];
    
    if (!exist) {
        id subClassObject = [[[self class] alloc] init];
//        ((QiaoArchiveBaseModel *) subClassObject).archiveFilePath = archiveFilePath == nil ? [[self filePath] stringByAppendingString:@"/ArchiveFiles"] : archiveFilePath;
        ((QiaoArchiveBaseModel *) subClassObject).archiveFileName = fileName;
        [subClassObject writeToFileWithArchiveFilePath:archiveFilePath fileName:archiveFileName];
        return subClassObject;
    }
    
    NSMutableData *data = [NSMutableData dataWithContentsOfFile:[writeToFilePath stringByAppendingString:fileName]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id subClassObject = [unarchiver decodeObjectForKey:NSStringFromClass([self class])];
    [unarchiver finishDecoding];
    
    return subClassObject;
}

+ (NSString *)filePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return path;
}

- (void)writeToFile
{
    [self writeToFileWithArchiveFilePath:nil fileName:_archiveFileName];
}

- (void)writeToFileWithArchiveFilePath:(NSString *)archiveFilePath fileName:(NSString *)archiveFileName
{
    // 文件的归档
    NSMutableData *data = [NSMutableData data ];
    // 创建一个归档类
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self forKey:NSStringFromClass([self class])];
    [archiver finishEncoding];
    
    NSString *writeToFilePath = archiveFilePath;
    if (writeToFilePath == nil) {
        writeToFilePath = [[[self class] filePath] stringByAppendingString:CachQiaoDirectory];
    }
    
    writeToFilePath = [writeToFilePath stringByAppendingString:@"/"];
    
    /// 创建目录
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *directoryPath = [NSString stringWithFormat:@"%@", writeToFilePath];
    BOOL isDirectory = NO;

    BOOL exist = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!exist && !isDirectory) {
        NSError *error = nil;
        BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:writeToFilePath withIntermediateDirectories:YES attributes:nil error:&error];
        NSAssert(bo,@"创建目录失败");
    }
    
    NSString *fileName = archiveFileName;
    if (fileName == nil || fileName.length == 0) {
        fileName = NSStringFromClass([self class]);
    }
    
//    //将数据写入文件里
    BOOL writeSucceed = [data writeToFile:[writeToFilePath stringByAppendingString:fileName] atomically:YES];
    NSAssert(writeSucceed, @"写入文件失败");

}

@end
