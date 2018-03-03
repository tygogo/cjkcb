//
//  DateUtils.m
//  goodgood
//
//  Created by GoGo on 15/10/5.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils
static NSString *CURRENTWEEK_KEY = @"current_week";
+(int)getCurrentWeek{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int week = [[ud objectForKey:CURRENTWEEK_KEY] intValue];
    
    return week ==0? 1:week;
}

+(void)setCurrentWeek:(int)week{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:[NSNumber numberWithInt:week] forKey:CURRENTWEEK_KEY];
}
@end
