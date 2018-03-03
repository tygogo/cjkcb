//
//  MyDataManager.m
//  goodgood
//
//  Created by GoGo on 15/9/28.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import "MyDataManager.h"
#import <FMDB.h>
#import "Crouse.h"
@interface MyDataManager()
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation MyDataManager

- (instancetype)initPrivate{
    self = [super init];
    if(self){
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject] stringByAppendingPathComponent:@"crouse.data"];
        self.db = [[FMDatabase alloc] initWithPath:path];
        if([self.db open]){
            if(![self.db tableExists:@"crouse"]){
                [self.db executeUpdate:@"create table if not exists crouse (name text, weekTime int,beginWeek int, endWeek int, orderTime int, teacher text, room text, extend int,color int)"];
            }
        }
    }
    return self;
}

+ (MyDataManager *)sharedMyDataBase{
    static MyDataManager *dbManager = nil;
    if(dbManager == nil){
        dbManager = [[MyDataManager alloc] initPrivate];
    }
    return dbManager;
}

- (NSArray *)getAllCrouse{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *sql = @"select name,beginWeek,endWeek,weekTime,orderTime,teacher,room,extend,color from crouse";
    FMResultSet *rs = [self.db executeQuery:sql];
    while (rs.next) {
        Crouse *crouse = [[Crouse alloc] init];
        crouse.name = [rs stringForColumn:@"name"];
        crouse.beginWeek = [rs intForColumn:@"beginWeek"];
        crouse.endWeek = [rs intForColumn:@"endWeek"];
        crouse.weekTime = [rs intForColumn:@"weekTime"];
        crouse.orderTime = [rs intForColumn:@"orderTime"];
        crouse.teacher = [rs stringForColumn:@"teacher"];
        crouse.room = [rs stringForColumn:@"room"];
        crouse.extend = [rs intForColumn:@"extend"];
        crouse.color = [rs intForColumn:@"color"];
        [array addObject:crouse];
    }
    return array;
}

- (BOOL)insertCrouse:(Crouse *)crouse{
    BOOL succes = [self.db executeUpdate:@"insert into crouse (name,beginWeek,endWeek,weekTime,orderTime,teacher,room,extend,color) values (?,?,?,?,?,?,?,?,?)"
     ,crouse.name
     ,[NSNumber numberWithInteger:crouse.beginWeek]
     ,[NSNumber numberWithInteger:crouse.endWeek]
     ,[NSNumber numberWithInteger:crouse.weekTime]
     ,[NSNumber numberWithInteger:crouse.orderTime]
     ,crouse.teacher
     ,crouse.room
     ,[NSNumber numberWithInteger:crouse.extend]
     ,[NSNumber numberWithInteger:crouse.color]
     ];
    return succes;
}

- (void) saveCrouse:(NSArray *)array{
    for(Crouse *crouse in array){
        [self insertCrouse:crouse];
        NSLog(@"%@", crouse.name);
    }
}

- (void)removeAll{
    NSString *sql = @"delete from crouse";
    [self.db executeUpdate:sql];
}

@end
