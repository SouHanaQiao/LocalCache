# LocalCache
简单的本地缓存
使用很简单
PersonCache *person = [[PersonCache alloc] init];
    person.dog.age = 1;
    person.dog.dogType = @"拉布拉多";
    person.dog.name = @"陈逗比";
    person.book.bookName = @"我的童年";
    person.book.price = 11.2;
    [person writeToFile];
    PersonCache *cachePerson = [PersonCache createObjectFromFile];
    NSLog(@"%@ %@ %@", cachePerson.dog.name, cachePerson.dog.dogType, cachePerson.book.bookName);
