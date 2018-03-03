//
//  LoginViewController.h
//  goodgood
//
//  Created by GoGo on 15/10/3.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginViewControllerDelegate<NSObject>

@optional
- (void) loginViewControllerDidLoadCrouse;
@end

@interface LoginViewController : UIViewController

@property (weak, nonatomic) id delegate;

@end
