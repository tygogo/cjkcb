//
//  CrouseListView.h
//  goodgood
//
//  Created by GoGo on 15/9/29.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CrouseListViewDelegate<NSObject>
@optional
- (void) crouseListViewDidClickCrouse:(NSArray*)crouses;

- (void) shareCourse;

@end

@interface CrouseListView : UIView

@property (nonatomic, weak) id delegate;
@property (nonatomic, assign) int currentWeek;

- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)array week:(int)week;

- (void)reloadWithArray:(NSArray *)array;
@end
