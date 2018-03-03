//
//  MyDataManager.h
//  goodgood
//
//  Created by GoGo on 15/9/28.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Crouse.h"
@interface MyDataManager : NSObject
- (instancetype)initPrivate;

+ (MyDataManager *)sharedMyDataBase;

- (NSArray *) getAllCrouse;

- (BOOL) insertCrouse:(Crouse *)crouse;

- (void) saveCrouse:(NSArray *)array;

- (void) removeAll;
@end
