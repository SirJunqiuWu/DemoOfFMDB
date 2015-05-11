//
//  UserInfoTableViewCell.h
//  DemoOfFMDB
//
//  Created by 蔡成汉 on 15/3/3.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserInfoTableViewCell : UITableViewCell

/**
 *  定义的KeyLabel -- 信息描述
 */
@property (nonatomic , strong) UILabel *keyLabel;

/**
 *  定义的ValLabel -- 信息结果
 */
@property (nonatomic , strong) UILabel *valLabel;

/**
 *  对外方法，用户获取用户信息 -- 需要tag值和val值
 *
 *  @param tag tag值，用来区分用户的哪一条信息，用于给keyLabel赋值
 *  @param user user值，用户信息
 */
-(void)setUserInfoTableViewCellWithTag:(NSInteger)tag user:(User *)user;

@end
