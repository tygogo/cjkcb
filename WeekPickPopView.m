//
//  weekPickPopView.m
//  goodgood
//
//  Created by GoGo on 15/10/5.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import "WeekPickPopView.h"
#import "DateUtils.h"
@interface WeekPickPopView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIImageView *bgImg;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIButton * btn;
@property (nonatomic, assign) int week;
@property (nonatomic,assign) int currentWeek;

@end

@implementation WeekPickPopView

- (instancetype)initWithFrame:(CGRect)frame andWeek:(int)week
{
    self = [super initWithFrame:frame];
    if (self) {
        self.week = week;
        self.currentWeek = [DateUtils getCurrentWeek];
        CGFloat padding = 4;
        CGFloat buttonHeight = 30;
        //background
        UIControl *bgView = [[UIControl alloc] initWithFrame:CGRectMake(0, 44 + 20, self.frame.size.width, self.frame.size.height - 44 - 20)];
        bgView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:0.5f];
        [bgView addTarget:self action:@selector(dismissPopview) forControlEvents:UIControlEventTouchUpInside];
        
        
        CGFloat w = 180;
        CGFloat h = 250;
        CGFloat x = self.frame.size.width * 0.5 - w * 0.5;
        CGFloat y = 0;

        
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popViewBg"]];
        img.frame = CGRectMake(x, y, w, h);
        self.bgImg = img;
        img.userInteractionEnabled = YES;

        [bgView addSubview:img];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(padding, padding + 10, img.frame.size.width -padding * 2, img.frame.size.height - padding * 3 - buttonHeight - 10)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 40;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.week-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.week-1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        
        self.tableView = tableView;
        [self.bgImg addSubview:tableView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"修改当前周" forState:UIControlStateNormal];
        CGFloat btnY = CGRectGetMaxY(tableView.frame) + padding;
        [button setBackgroundImage:[UIImage imageNamed:@"week_pick_btn"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:101/255.0f green:184/255.0f blue:10/255.0f alpha:1.0f] forState:UIControlStateNormal];
        button.frame = CGRectMake(padding, btnY, img.frame.size.width -padding * 2, buttonHeight);
        button.alpha = 0.9f;
        
        [button addTarget:self action:@selector(changeWeek) forControlEvents:UIControlEventTouchUpInside];
        
        [img addSubview:button];
        
        [self addSubview:bgView];
    }
    return self;
}

- (void) dismissPopview{
    [self removeFromSuperview];
}


#pragma -mark tableview Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 25;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor colorWithRed:0.f/255 green:122.0f/255 blue:220.0f/255 alpha:1.0f];
        //设置高亮颜色
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:3.0f/255 green:122.0f/255 blue:255.0f/255 alpha:1.0f];
        cell.selectedBackgroundView.layer.cornerRadius = 4;
        cell.selectedBackgroundView.layer.masksToBounds = YES;
        cell.textLabel.highlightedTextColor = [UIColor colorWithWhite:0.95f alpha:0.9f];
    }
    if((int)indexPath.row+1 == self.currentWeek){
        cell.textLabel.text = [NSString stringWithFormat:@"第%ld周(本周)",(long)indexPath.row + 1];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"第%ld周",(long)indexPath.row + 1];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate respondsToSelector:@selector(weekPickPopView:didSelectWeek:)]){
        [self.delegate weekPickPopView:self didSelectWeek:(int)indexPath.row + 1];
    }
    [self dismissPopview];
    
}

-(void) changeWeek{
    if([self.delegate respondsToSelector:@selector(clickChangeBtn)]){
        [self.delegate clickChangeBtn];
    }
    [self dismissPopview];
}

@end
