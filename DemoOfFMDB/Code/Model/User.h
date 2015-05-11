//
//  User.h
//  DemoOfFMDB
//
//  Created by 蔡成汉 on 15/2/28.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, UserSex)
{
    /**
     *  性别为男
     */
    UserSexBoy = 0,
    
    /**
     *  性别为女
     */
    UserSexGirl = 1
};

typedef NS_ENUM(NSInteger, UserDuty)
{
    /**
     *  学生
     */
    UserDutyStudent = 0,
    
    /**
     *  开发者
     */
    UserDutyDevelopers = 1,
    
    /**
     *  工人
     */
    UserDutyWorkers = 2
};

@interface User : NSObject

/**
 *  用户id
 */
@property (nonatomic , assign) int userId;

/**
 *  用户名
 */
@property (nonatomic , strong) NSString *userName;

/**
 *  用户年龄
 */
@property (nonatomic , assign) int userAge;

/**
 *  用户性别 - 0表示男，1表示女
 */
@property (nonatomic , assign) UserSex userSex;

/**
 *  用户职业
 */
@property (nonatomic , assign) UserDuty userDuty;

#pragma mark FMDB

/**
 *  存储用户信息
 *
 *  @param user 用户信息
 *
 *  @return YES表示存储成功，NO表示存储失败
 */
+(BOOL)saveUser:(User *)user;

/**
 *  获取所有的用户信息
 *
 *  @return 所有用户信息的数组
 */
+(NSMutableArray *)getAllUserInfo;

/**
 *  获取用户信息 - 根据用户id
 *
 *  @param id 目标用户的id
 *
 *  @return 指定用户的所有信息
 */

+(NSMutableArray *)getSelectUserById:(int)userId;

/**
 *  删除用户信息 - 根据用户id
 *
 *  @param id 目标用户的id
 *
 *  @return YES表示成功，NO表示失败
 */
+(BOOL)deleteUserById:(int)userId;

/**
 *  删除所有的用户信息
 *
 *  @return YES表示删除成功，NO表示删除失败
 */
+(BOOL)deleteAllUser;

@end
