//
//  LoginViewController.m
//  goodgood
//
//  Created by GoGo on 15/10/3.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import "LoginViewController.h"
#import <AFNetworking.h>
#import "MyDataManager.h"
#import "Crouse.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *snumTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@property (nonatomic, strong) NSString *cookie;

@end

@implementation LoginViewController
-(AFHTTPRequestOperationManager *)manager{
    if(_manager == nil){
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCheckCode];
    // Do any additional setup after loading the view.
}

- (IBAction)login:(UIButton *)sender {
    NSString *snum = self.snumTextField.text;
    NSString *pwd = self.pwdTextField.text;
    NSString *checkCode = self.codeTextField.text;
    if(snum.length != 0 && pwd.length != 0 && checkCode.length == 4 && self.cookie != nil){
        [self getCrouseWithSession:self.cookie andSnum:snum password:pwd checkCode:checkCode];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) getCheckCode{
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    NSDictionary *param = @{@"token":@"1",
                            @"year":@"2014-2015",
                            @"term":@"2",
                            @"classnum":@"13101010412",
                            @"password":@"nishengri7",
                            @"yzm":@"",
                            @"mode":@"yzm",
                            @"cookie":@""};

    [self.manager POST:@"http://class.dingliqc.com/getclass.php" parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves   error:nil];
        NSData *base64Data = [[NSData alloc] initWithBase64EncodedString:jsonDict[@"img"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        self.codeImageView.image = [UIImage imageWithData:base64Data];
        self.cookie = jsonDict[@"session"];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"POST Error: %@",error);
    }];

}

- (void) getCrouseWithSession:(NSString *)session andSnum:(NSString*)snum password:(NSString *)password checkCode:(NSString*) checkcode{
    NSDictionary *param = @{@"token":@"1",
                            @"year":@"2015-2016",
                            @"term":@"1",
                            @"classnum":snum,
                            @"password":password,
                            @"yzm":checkcode,
                            @"mode":@"",
                            @"cookie":session};

    [self.manager POST:@"http://class.dingliqc.com/getclass.php" parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //        NSLog(@"%@",[NSString e]);
        NSString * data = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        NSArray *crouses = [Crouse crousesWithArray:dict[@"map"]];
        [[MyDataManager sharedMyDataBase] removeAll];
        [[MyDataManager sharedMyDataBase] saveCrouse:[Crouse combineSameCrouse:crouses]];
        if([self.delegate respondsToSelector:@selector(loginViewControllerDidLoadCrouse)]){
            [self.delegate loginViewControllerDidLoadCrouse];
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"POST Error: %@",error);
    }];
    
}

@end
