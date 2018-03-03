//
//  CrouseListView.m
//  goodgood
//
//  Created by GoGo on 15/9/29.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import "CrouseListView.h"
#import "Crouse.h"
#import "ColorUtils.h"
#define kAlpha 0.8f
#define kBarAlpha 0.2f
@interface CrouseListView()<UIScrollViewDelegate>
@property (nonatomic,strong) NSArray *crouseList;
@property (nonatomic,weak) UIScrollView *scrollView;

@property (nonatomic, weak) UIView *leftBar;
@property (nonatomic, weak) UIView *crouseArea;
@property (nonatomic, strong) NSArray *clickArray;
@property (nonatomic, weak) UIButton *shareBtn;
@end
@implementation CrouseListView
int crouseHeight = 45;
int seperaLineWidth = 1;
int topBarHeight = 18;
int leftBarWidth = 18;


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)array week:(int)week{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithWhite:0.97f alpha:0.7f];
        self.crouseList = array;
        _currentWeek = week;
        self.alpha = kAlpha;
        UIImage *bg = [UIImage imageNamed:@"course_bg"];
    
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        imgView.image = bg;
//        [imgView setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview: imgView];
        
        [self createTopBar];
        [self createLeftbar];
        [self createView];
        self.shareBtn;
        
        for(Crouse *c in array){
            NSLog(@"%@ >>%d",c.name, c.color);
        }

    }
    return self;
}

- (void)setCurrentWeek:(int)currentWeek{
    NSLog(@"dasdsa");
    _currentWeek = currentWeek;
    [self reloadData];
}

-(NSArray *)clickArray{
    if(_clickArray == nil){
        NSLog(@"=======");
        NSMutableArray *arrayM = [[NSMutableArray alloc] init];
        for(int i=0; i<self.crouseList.count; i++){
            NSMutableArray *array = [[NSMutableArray alloc] init];
            [array addObject:[NSNumber numberWithInteger:i]];
            [arrayM addObject: array] ;
        }
        _clickArray= arrayM;
    }
    return _clickArray;
}

-(UIButton *)shareBtn{
    if(_shareBtn == nil){
        UIButton *button = [[UIButton alloc] init];
        [button setBackgroundImage:[UIImage imageNamed:@"course_share4"] forState:UIControlStateNormal];
        CGFloat x = self.frame.size.width - 74;
        CGFloat y = self.frame.size.height - 47 - 44;
        button.frame = CGRectMake(x, y, 74, 47);
        [button addTarget:self action:@selector(shareCourseClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _shareBtn = button;
    }
    return _shareBtn;
}

-(UIView *)crouseArea{
    if(_crouseArea == nil){
        UIView *crouseArea = [[UIView alloc] initWithFrame:CGRectMake(leftBarWidth, 0, self.scrollView.frame.size.width - leftBarWidth, self.scrollView.contentSize.height)];
        _crouseArea = crouseArea;
        _crouseArea.alpha = 0.9f;
        [self.scrollView addSubview:_crouseArea];
    }
    return _crouseArea;
}

- (UIView *)leftBar{
    if(_leftBar == nil){
        UIView *leftBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftBarWidth, self.scrollView.contentSize.height)];
        leftBar.backgroundColor = [UIColor whiteColor];
        _leftBar =leftBar;
        [self.scrollView addSubview:_leftBar];
    }
    return _leftBar;
}

- (UIScrollView *)scrollView{
    if(_scrollView == nil){
        UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topBarHeight, self.frame.size.width, self.frame.size.height - topBarHeight)];
        _scrollView = sv;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(0, (crouseHeight+seperaLineWidth) * 14 + seperaLineWidth) ;
        [self addSubview:_scrollView];

    }
    return _scrollView;
}


-(void) createView{
    
    [self.scrollView bringSubviewToFront:self.crouseArea];
    int colWidth = self.crouseArea.frame.size.width / 7 - seperaLineWidth ;
    for (int i=0;i< self.crouseList.count;i++) {
        Crouse *crouse = self.crouseList[i];
        
        CGFloat x = seperaLineWidth + (crouse.weekTime -1) * (colWidth + seperaLineWidth) ;
        CGFloat y = seperaLineWidth + (crouse.orderTime -1) * (crouseHeight + seperaLineWidth);
        CGFloat w = colWidth;
        CGFloat h = crouse.extend * (crouseHeight +seperaLineWidth) - seperaLineWidth;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
        button.tag = i;
        
        //本周上课
        BOOL haveLesson = [Crouse haveLesson:crouse atWeek:self.currentWeek];
        
        if(haveLesson){
//            [button setBackgroundColor:[UIColor colorWithRed:244.0f/255 green:136.0f/255 blue:139.0f/255 alpha:1.0f]];
            [button setBackgroundColor:[ColorUtils ColorByIndex:crouse.color]];
        }else{
            [button setBackgroundColor:[ColorUtils ColorByIndex:99]];
            [button setTitleColor:[UIColor colorWithWhite:0.2 alpha:0.7f] forState:UIControlStateNormal];
        }
        
        [button setTitle:[NSString stringWithFormat:@"%@\n%@",crouse.name,crouse.room] forState:UIControlStateNormal];
        
//        button.alpha = 0.83f;
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        button.titleLabel.textAlignment = NSTextAlignmentLeft;
        button.titleLabel.numberOfLines = 0;
        
        [button addTarget:self action:@selector(onCrouseClick:) forControlEvents:UIControlEventTouchUpInside];

        [self.crouseArea addSubview:button];
        

        for(UIButton *btn in self.crouseArea.subviews){
            if(button == btn){
                continue;
            }
            if(CGRectIntersectsRect(btn.frame, button.frame)){
                if(haveLesson){//当前课要上
                    [btn removeFromSuperview];
                
                    NSMutableArray *array = self.clickArray[i];
                    [array addObject:[NSNumber numberWithInteger:btn.tag]];
                    [button setBackgroundImage:[UIImage imageNamed:@"CrouseBg"] forState:UIControlStateNormal];
                }else if([Crouse haveLesson:self.crouseList[btn.tag] atWeek:self.currentWeek]){//重叠课要上
                    [button removeFromSuperview];
                    NSMutableArray *array = self.clickArray[btn.tag];
                    [array addObject:[NSNumber numberWithInteger: i]];
                    [btn setBackgroundImage:[UIImage imageNamed:@"CrouseBg"] forState:UIControlStateNormal];

                }else{//都不上
                    [btn removeFromSuperview];
                    NSMutableArray *array = self.clickArray[i];
                    [array addObject: [NSNumber numberWithInteger: btn.tag]];
                    [button setBackgroundImage:[UIImage imageNamed:@"CrouseBg"] forState:UIControlStateNormal];

                }
            }
        }
        

    }
}

- (void) removeCourse{
    for(UIView *view in self.crouseArea.subviews){
        [view removeFromSuperview];
    }
}


-(void) createLeftbar{
    
    for(int i=0; i<14;i++){
        CGFloat y = seperaLineWidth + i * (crouseHeight + seperaLineWidth);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, leftBarWidth, crouseHeight)];
        label.text = [NSString stringWithFormat:@"%d",i+1];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:0.f/255 green:122.0f/255 blue:220.0f/255 alpha:1.0f];
        [self.leftBar addSubview:label];
        self.leftBar.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.2f];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, y-seperaLineWidth, self.scrollView.frame.size.width, seperaLineWidth)];
        line.backgroundColor = [UIColor colorWithRed:0.f/255 green:122.0f/255 blue:220.0f/255 alpha:1.0f];
        line.alpha = 0.1f;
        [self.scrollView addSubview:line];
    }
}

-(void) createTopBar{
    int colWidth = self.crouseArea.frame.size.width / 7 - seperaLineWidth ;

    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, topBarHeight)];
    topView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.2f];
    [self addSubview:topView];
    for(int i=0;i<7;i++){
        CGFloat x = seperaLineWidth + leftBarWidth + i * (colWidth + seperaLineWidth);
        CGFloat w = colWidth;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, w, topBarHeight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.text = [NSString stringWithFormat:@"%d",i+1];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor colorWithRed:0.f/255 green:122.0f/255 blue:220.0f/255 alpha:1.0f];
        [topView addSubview:label];
        
        CGFloat lineX = x-seperaLineWidth;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(lineX, 0, seperaLineWidth, self.frame.size.height)];
        line.backgroundColor = [UIColor colorWithRed:0.f/255 green:122.0f/255 blue:220.0f/255 alpha:1.0f];
        line.alpha = 0.1f;
        [self addSubview:line];
    }
}

- (void)reloadWithArray:(NSArray *)array{
    self.crouseList = array;
    [self reloadData];
}

- (void) reloadData{
    for (UIView * v in self.crouseArea.subviews) {
        [v removeFromSuperview];
    }
    _clickArray = nil;
    [self createView];
}


- (void)onCrouseClick:(UIButton*) btn{
    
    NSMutableArray *array = self.clickArray[btn.tag];
    NSMutableArray *crouseArray = [[NSMutableArray alloc] init];
    
    for(NSNumber *number in array){
        NSLog(@"%d",number.intValue);
        Crouse *crouse = self.crouseList[number.intValue];
        [crouseArray addObject:crouse];
    }
    
    if([self.delegate respondsToSelector:@selector(crouseListViewDidClickCrouse:)]){
        [self.delegate crouseListViewDidClickCrouse:crouseArray];
    }
}

#pragma -mark scrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    if(offset > self.scrollView.contentSize.height - self.scrollView.frame.size.height - 10){
        self.shareBtn.hidden = YES;
    }else{
        self.shareBtn.hidden = NO;
    }
}

#pragma - mark ShareButton click
- (void) shareCourseClick:(UIButton *)sender{
    if([self.delegate respondsToSelector:@selector(shareCourse)]){
        [self.delegate shareCourse];
    }
}

@end
