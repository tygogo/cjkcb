//
//  CrouseSelectView.m
//  goodgood
//
//  Created by GoGo on 15/10/4.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import "CrouseSelectView.h"
#import "Crouse.h"
#import "ColorUtils.h"
@interface CrouseSelectView()
@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation CrouseSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

int crouseWidth = 200;
- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        self.crouses = array;
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        self.scrollView;
        [self addTarget:self action:@selector(dismissView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (UIScrollView *)scrollView{
    if(_scrollView == nil){
        CGFloat h = 300;
        CGFloat x = 0;
        CGFloat y = self.frame.size.height *0.5 - h * 0.5;
        CGFloat w = self.frame.size.width;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        int padding = (self.frame.size.width - crouseWidth) * 0.25;
        CGFloat sizeW = self.crouses.count * crouseWidth + (self.crouses.count + 1) * padding;
        scrollView.contentSize = CGSizeMake(sizeW, 0);
        
        scrollView.contentOffset = CGPointMake(-padding, 0);
        scrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:scrollView];
        
        _scrollView = scrollView;
        
        [self addCrouseDetail];
        
    }
    return _scrollView;
}

- (void) addCrouseDetail{
    
    for(int i=0; i<self.crouses.count; i++){
        Crouse *crouse = self.crouses[i];
        
        int padding = (self.frame.size.width - crouseWidth) * 0.25;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(padding + i * (crouseWidth +padding), 0, crouseWidth, self.scrollView.frame.size.height)];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:crouse.name forState:UIControlStateNormal];
        btn.titleLabel.numberOfLines = 0;
        btn.tag = i;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:20];
        btn.titleLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
        btn.backgroundColor = [ColorUtils ColorByIndex:crouse.color];
        
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
    }
}

- (void) dismissView:(id)sender{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

-(void) clickBtn:(UIButton *)sender{
    if([self.delegate respondsToSelector:@selector(crouseSelectview:didSelectCrouse:)]){
        [self.delegate crouseSelectview:self didSelectCrouse:self.crouses[sender.tag]];
    }
}
@end
