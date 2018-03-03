//
//  weekPickPopView.h
//  goodgood
//
//  Created by GoGo on 15/10/5.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeekPickPopView;

@protocol WeekPickPopViewDelegate<NSObject>

@optional

- (void)weekPickPopView:(WeekPickPopView *)weekPickPopView didSelectWeek:(int) week;

- (void)clickChangeBtn;
@end

@interface WeekPickPopView : UIView

- (instancetype)initWithFrame:(CGRect)frame andWeek:(int) week;

@property (nonatomic,weak) id delegate;
@end
