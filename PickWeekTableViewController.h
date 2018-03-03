//
//  PickWeekViewControllerTableViewController.h
//  goodgood
//
//  Created by GoGo on 15/10/5.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PickWeekTableViewControllerDelegate <NSObject>
@optional
- (void)didChangeCurrentWeekTo:(int)week;
@end

@interface PickWeekTableViewController : UITableViewController
@property (nonatomic,weak) id delegate;
@end
