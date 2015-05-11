//
//  BasicUserInfoTableViewCell.h
//  DemoOfFMDB
//
//  Created by 蔡成汉 on 15/2/28.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface BasicUserInfoTableViewCell : UITableViewCell

/**
 *  用户名
 */
@property (nonatomic , strong) UILabel *userNameLabel;

/**
 *  用户职位
 */
@property (nonatomic , strong) UILabel *userDutyLabel;

/**
 *  对外方法，用于cell上的获取用户信息
 *
 *  @param user cell上的用户信息
 */
-(void)setBasicUserInfoTableViewCellWithUser:(User *)user;

@end
