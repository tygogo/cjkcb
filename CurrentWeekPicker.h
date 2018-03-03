//
//  CurrentWeekPicker.h
//  goodgood
//
//  Created by GoGo on 15/10/6.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CurrentWeekPicker;

@protocol CurrentWeekPickerDelegate
@optional
- (void)currentWeekPicker:(CurrentWeekPicker *)currentWeekPicker didselectWeek:(int)week;
@end

@interface CurrentWeekPicker : UIView

@property (nonatomic, weak) id delegate;

- (instancetype)initWithFrame:(CGRect)frame andCurrentWeek:(int)currentWeek;
@end
