//
//  CurrentWeekPicker.m
//  goodgood
//
//  Created by GoGo on 15/10/6.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import "CurrentWeekPicker.h"
@interface CurrentWeekPicker()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, assign) int week;
@property (nonatomic, assign) int selectWeek;
@property (nonatomic, weak) UILabel *textLabel;
@property (nonatomic, weak) UIPickerView *pickerView;
@end


@implementation CurrentWeekPicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame andCurrentWeek:(int)currentWeek{
    if(self = [super initWithFrame:frame]){
        self.week = currentWeek;
        self.selectWeek = currentWeek;
        self.backgroundColor = [UIColor whiteColor];
        [self createView];
        
    }
    return self;
}


-(void) createView{
    CGFloat padding = 4;
    
    //topBar
    UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    topBar.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
    [self addSubview:topBar];
    
    //button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.frame = CGRectMake(topBar.frame.size.width - btn.frame.size.width - padding,
                           topBar.frame.size.height * 0.5 - btn.frame.size.height * 0.5,
                           btn.frame.size.width,
                           btn.frame.size.height);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topBar addSubview:btn];
    
    //Label
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"当前为第%d周",self.week];
    label.textColor = [UIColor colorWithWhite:0.0f alpha:0.9f];
    label.textAlignment = NSTextAlignmentCenter;
    self.textLabel = label;
    label.frame = CGRectMake(padding, 0, self.frame.size.width - padding, topBar.frame.size.height);
    [topBar addSubview:label];
    
    //PickerView
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,
                                                                         CGRectGetMaxY(topBar.frame),
                                                                         self.frame.size.width,
                                                                          self.frame.size.height- padding - topBar.frame.size.height)];
    self.pickerView = picker;
    picker.delegate = self;
    picker.dataSource = self;
//    picker.backgroundColor = [UIColor orangeColor];
    
    [picker selectRow:self.week - 1 inComponent:0 animated:YES];
    [self addSubview:picker];
}

-(void)btnClick:(UIButton *)sender{
    if([self.delegate respondsToSelector:@selector(currentWeekPicker:didselectWeek:)]){
        [self.delegate currentWeekPicker:self didselectWeek:self.selectWeek];
    }
}



#pragma -mark PickerView Delegate&&DataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 25;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"第%ld周",(long)row + 1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.textLabel.text = [NSString stringWithFormat:@"当前为第%ld周",row + 1];
    self.selectWeek = row + 1;
}
@end
