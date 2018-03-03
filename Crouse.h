//
//  Crouse.h
//  goodgood
//
//  Created by GoGo on 15/9/28.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Crouse : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int beginWeek;
@property (nonatomic, assign) int endWeek;
@property (nonatomic, assign) int weekTime;
@property (nonatomic, assign) int orderTime;
@property (nonatomic, strong) NSString *teacher;
@property (nonatomic, strong) NSString *room;
@property (nonatomic, assign) int extend;
@property (nonatomic, assign) int color;

- (Crouse *) initWithDict:(NSDictionary *)dict;

+ (NSArray *) combineSameCrouse:(NSArray *)array;

+ (NSArray *)crousesWithArray:(NSArray *)array;

+ (BOOL) haveLesson:(Crouse*) crouse atWeek:(int) week;
@end
