//
//  ViewController.m
//  超简单本地缓存
//
//  Created by 葬花桥 on 15/7/21.
//  Copyright (c) 2015年 mmedi.cn. All rights reserved.
//

#import "ViewController.h"
#import "PersonCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PersonCache *person = [[PersonCache alloc] init];
    person.dog.age = 1;
    person.dog.dogType = @"拉布拉多";
    person.dog.name = @"陈逗比";
    person.book.bookName = @"我的童年";
    person.book.price = 11.2;
    [person writeToFile];
                           
    PersonCache *cachePerson = [PersonCache createObjectFromFile];
    NSLog(@"%@ %@ %@", cachePerson.dog.name, cachePerson.dog.dogType, cachePerson.book.bookName);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
