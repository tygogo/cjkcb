//
//  ColorUtils.m
//  goodgood
//
//  Created by GoGo on 15/10/5.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import "ColorUtils.h"

@implementation ColorUtils
+ (UIColor*) ColorByIndex:(int)index{
    switch (index) {
        case 0://
            return [UIColor colorWithRed:244.0f/255 green:136.0f/255 blue:139.0f/255 alpha:1.0f];
        case 1://
            return [UIColor colorWithRed:175.0f/255 green:94.0f/255 blue:156.0f/255 alpha:1.0f];
        case 2://
            return [UIColor colorWithRed:53.0f/255 green:127.0f/255 blue:235.0f/255 alpha:1.0f];
        case 3://
            return [UIColor colorWithRed:74.0f/255 green:186.0f/255 blue:139.0f/255 alpha:1.0f];
        case 4://
            return [UIColor colorWithRed:255.0f/255 green:191.0f/255 blue:59.0f/255 alpha:1.0f];
        case 5://
            return [UIColor colorWithRed:32.0f/255 green:177.0f/255 blue:140.0f/255 alpha:1.0f];
        case 99:
            return [UIColor colorWithRed:226.0f/255 green:226.0f/255 blue:226.0f/255 alpha:10.f];
        default:
            NSLog(@"default");
            return [UIColor colorWithRed:244.0f/255 green:136.0f/255 blue:139.0f/255 alpha:1.0f];
            break;
    }
}

@end
