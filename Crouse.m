//
//  Crouse.m
//  goodgood
//
//  Created by GoGo on 15/9/28.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import "Crouse.h"

@implementation Crouse
- (Crouse *)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        self.name = dict[@"name"];
        self.beginWeek = [dict[@"beginWeek"] intValue];
        self.endWeek = [dict[@"endWeek"] intValue];
        self.weekTime = [dict[@"weekTime"] intValue];
        self.orderTime = [dict[@"orderTime"] intValue];
        self.teacher = dict[@"teacher"];
        self.room = dict[@"room"];
        self.extend = [dict[@"extend"] intValue];
    }
    return self;
}



+ (NSArray *)crousesWithArray:(NSArray *)array{
    NSMutableArray *arrayM = [[NSMutableArray alloc] init];
    int color = 0;
    for(NSDictionary *dict in array){
        Crouse *crouse = [[Crouse alloc] initWithDict:dict];
        BOOL alreadyHasColor = NO;
        for(Crouse *c in arrayM){
            if([c.name isEqualToString:crouse.name]){
                alreadyHasColor = YES;
                crouse.color = c.color;
            }
        }
        if(!alreadyHasColor){
            crouse.color = color % 5;
            NSLog(@"%@---%d---",crouse.name,color% 5);
            color ++;
        }
        [arrayM addObject:crouse];
    }
    return arrayM;
}

+ (NSArray *)combineSameCrouse:(NSArray *)array{
    NSMutableArray *arrayM = [[NSMutableArray alloc] initWithArray:array];
    NSMutableArray *arrayM2 = [[NSMutableArray alloc] init];
    for (Crouse *crouse in arrayM) {
        for(Crouse *crouse2 in arrayM){
            if (crouse.weekTime == crouse2.weekTime
                && [crouse.room isEqualToString:crouse2.room]
                && [crouse.name isEqualToString:crouse2.name]){
                if(crouse.orderTime + crouse.extend == crouse2.orderTime){
                    crouse.extend = crouse.extend +crouse2.extend;
                    [arrayM2 addObject:crouse2];
                }
            }
        }
    }
    [arrayM removeObjectsInArray:arrayM2];
    return arrayM;
}

+ (BOOL) haveLesson:(Crouse*) crouse atWeek:(int) week{
    return (crouse.beginWeek <= week &&
            crouse.endWeek >= week);
}

@end
