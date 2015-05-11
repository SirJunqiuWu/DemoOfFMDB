//
//  UserInfoViewController.h
//  DemoOfFMDB
//
//  Created by 蔡成汉 on 15/3/3.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserInfoViewController : UIViewController

/**
 *  当前VC的User -- 数据来自上一层VC
 */

@property (nonatomic ,strong) User *currentUser;

@end
