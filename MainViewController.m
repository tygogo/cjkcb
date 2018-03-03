//
//  MainViewController.m
//  goodgood
//
//  Created by GoGo on 15/10/3.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "CrouseListView.h"
#import "MyDataManager.h"
#import "CrouseSelectView.h"
#import "WeekPickPopView.h"
#import "DateUtils.h"
#import "PickWeekTableViewController.h"
#import "CourseDetailTableViewController.h"
@interface MainViewController ()<LoginViewControllerDelegate,
CrouseListViewDelegate,
WeekPickPopViewDelegate,
PickWeekTableViewControllerDelegate,
CrouseSelectViewDelegate>

@property (nonatomic, strong) CrouseListView *crouseListView;
@property (nonatomic, weak) UIButton *weekPickerBtn;
@property (nonatomic, assign) int currentWeek;
@property (nonatomic, assign) int selectWeek;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.currentWeek = [DateUtils getCurrentWeek];
    self.selectWeek = self.currentWeek;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.weekPickerBtn = btn;
    [btn setTitle:[NSString stringWithFormat:@"第%d周▼",self.currentWeek] forState:UIControlStateNormal];
    btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y, 200, btn.frame.size.height);
    self.navigationItem.titleView = btn;
    
    [btn addTarget:self action:@selector(popWeekPickerView) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSArray *array = [[MyDataManager sharedMyDataBase] getAllCrouse];
    self.crouseListView = [[CrouseListView alloc] initWithFrame:CGRectMake(0, 20+44, self.view.frame.size.width, self.view.frame.size.height - 20 - 44) andArray:array week:self.currentWeek];
    self.crouseListView.delegate = self;
    
    [self.view addSubview:self.crouseListView];
    
    // Do any additional setup after loading the view.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if( [segue.destinationViewController isKindOfClass:[LoginViewController class]]){
        LoginViewController *loginVc = segue.destinationViewController;
        loginVc.delegate = self;
    }
}

-(void)loginViewControllerDidLoadCrouse{
    NSArray *array = [[MyDataManager sharedMyDataBase] getAllCrouse];
    [self.crouseListView reloadWithArray:array];
}

-(void)crouseListViewDidClickCrouse:(NSArray *)crouses{
    if(crouses.count == 1){
        [self selectCrouse:crouses[0]];
    }else{
        CrouseSelectView *selectView = [[CrouseSelectView alloc] initWithFrame:self.view.frame andArray:crouses];
        selectView.delegate = self;
        selectView.alpha = 0;
        [self.view addSubview:selectView];
        [UIView animateWithDuration:0.3 animations:^{
            selectView.alpha = 1.0f;
        }];
    }
}

-(void)shareCourse{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"哦哦" message:@"嗯嗯" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"bye" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) popWeekPickerView{
    WeekPickPopView *pickView = [[WeekPickPopView alloc] initWithFrame:self.view.frame andWeek:self.selectWeek];
    pickView.delegate = self;
    pickView.alpha = 0.85f;
    [self.view addSubview: pickView];
}


#pragma - mark weekPickDelegate

-(void)weekPickPopView:(WeekPickPopView *)weekPickPopView didSelectWeek:(int)week{
    [self.crouseListView setCurrentWeek:week];
    self.selectWeek = week;
    [self reloadCrouseLabel];
}

//刷新选择周数label的显示
- (void) reloadCrouseLabel{
    if(self.selectWeek == self.currentWeek){
        [self.weekPickerBtn setTitle:[NSString stringWithFormat:@"第%d周▼",self.selectWeek] forState:UIControlStateNormal];
        [self.weekPickerBtn setTitleColor:[UIColor colorWithRed:3.0f/255 green:122.0f/255 blue:255.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    }else{
        [self.weekPickerBtn setTitle:[NSString stringWithFormat:@"第%d周(非本周)▼",self.selectWeek] forState:UIControlStateNormal];
        [self.weekPickerBtn setTitleColor:[UIColor colorWithRed:245.0f/255 green:166.0f/255 blue:35.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    }

}



-(void)clickChangeBtn{
    PickWeekTableViewController *cv = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"pick_week"];
//    [self presentViewController:cv animated:YES completion:nil];
    cv.delegate = self;
    [self.navigationController pushViewController:cv animated:YES];
}

#pragma -mark pickerViewControllerDelegate

-(void)didChangeCurrentWeekTo:(int)week{
    NSLog(@"asfasf");
    self.selectWeek = week;
    self.currentWeek = week;
    [self.crouseListView setCurrentWeek:week];
    [self reloadCrouseLabel];
}

#pragma -mark selectViewDelegate

- (void) crouseSelectview:(CrouseSelectView *)crouseSelectView didSelectCrouse:(Crouse *)crouse{
    NSLog(@"%@",crouse.name);
    [self selectCrouse:crouse];
    [crouseSelectView removeFromSuperview];
    
}

-(void) selectCrouse:(Crouse *)crouse{
    CourseDetailTableViewController *vc = [[CourseDetailTableViewController alloc] initWithStyle:UITableViewStyleGrouped
                                           ];
    vc.crouse = crouse;
    [self.navigationController pushViewController:vc animated:YES];

}


@end
