//
//  PickWeekViewControllerTableViewController.m
//  goodgood
//
//  Created by GoGo on 15/10/5.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import "PickWeekTableViewController.h"
#import "CurrentWeekPicker.h"
#import "DateUtils.h"
@interface PickWeekTableViewController ()<CurrentWeekPickerDelegate>
@property (nonatomic, weak) CurrentWeekPicker *weekPicker;
@property (nonatomic, weak) UIControl *bgView;
@property (nonatomic, assign) int currentWeek;
@end

@implementation PickWeekTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.currentWeek = [DateUtils getCurrentWeek];
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_setcurrentweek_tip"]];
    img.frame = CGRectMake(self.view.frame.size.width * 0.5 - img.frame.size.width * 0.5, self.view.frame.size.height - 20 - 44 - img.frame.size.height, 215, 104);
    [self.view addSubview:img];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self setWeekCellDisplay:self.currentWeek];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setWeekCellDisplay:(int)week{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"第%d周", week];
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hello" message:@"sdsad" preferredStyle:UIAlertControllerStyleActionSheet];
//            [alert addAction:[UIAlertAction actionWithTitle:@"xsad" style:UIAlertActionStyleDefault handler:nil]];
//            [self presentViewController:alert animated:YES completion:nil];
            [self showPickView];
        }
            break;
        default:
            break;
    }
}

- (void) showPickView{
    UIControl *bgView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 20 - 44)];
    bgView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.2f];
    [bgView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    self.bgView = bgView;
    CGFloat weekPickerHeight = 300;
    CurrentWeekPicker *weekPicker = [[CurrentWeekPicker alloc] initWithFrame:CGRectMake(0,
                                                                  bgView.frame.size.height,
                                                                  self.view.frame.size.width,weekPickerHeight) andCurrentWeek:self.currentWeek];
    weekPicker.delegate = self;
    self.weekPicker = weekPicker;
    [bgView addSubview:weekPicker];
    [self.view addSubview:bgView];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        weekPicker.frame = CGRectMake(weekPicker.frame.origin.x,
                                      bgView.frame.size.height - weekPickerHeight,
                                      weekPicker.frame.size.width,
                                      weekPicker.frame.size.height);
    } completion:nil];
}

-(void) dismiss{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.weekPicker.frame = CGRectMake(self.weekPicker.frame.origin.x,
                                      self.view.frame.size.height - 20 - 44,
                                      self.weekPicker.frame.size.width,
                                      self.weekPicker.frame.size.height);
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
    }];
    
}


#pragma -mark currentWeekPicker Delegate

- (void)currentWeekPicker:(CurrentWeekPicker *)currentWeekPicker didselectWeek:(int)week{
    [DateUtils setCurrentWeek:week];
    self.currentWeek = week;
    [self setWeekCellDisplay:week];
    if([self.delegate respondsToSelector:@selector(didChangeCurrentWeekTo:)]){
        [self.delegate didChangeCurrentWeekTo:week];
    }
    
    [self dismiss];
}
@end
