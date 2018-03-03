//
//  CrouseSelectView.h
//  goodgood
//
//  Created by GoGo on 15/10/4.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Crouse;
@class CrouseSelectView;
@protocol CrouseSelectViewDelegate <NSObject>
@optional
- (void) crouseSelectview:(CrouseSelectView *)crouseSelectView didSelectCrouse:(Crouse*) crouse;
@end

@interface CrouseSelectView : UIControl
@property (nonatomic, strong) NSArray *crouses;
@property (nonatomic, weak) id delegate;
- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)array;

@end
