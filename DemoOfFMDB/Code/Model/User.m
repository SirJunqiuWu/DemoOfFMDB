//
//  User.m
//  DemoOfFMDB
//
//  Created by 蔡成汉 on 15/2/28.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "User.h"
#import "FMDBConfig.h"

@implementation User

#pragma mark FMDB

/**
 *  存储用户信息
 *
 *  @param user 用户信息
 *
 *  @return YES表示存储成功，NO表示存储失败
 */
+(BOOL)saveUser:(User *)user
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open])
    {
        return NO;
    };
    
    [User checkTableCreatedInDb:db];
    
    NSString *insertStr=@"REPLACE INTO 'myUserTable' ('userId','userName','userAge','userSex','userDuty') VALUES (?,?,?,?,?)";
    BOOL worked = [db executeUpdate:insertStr,[NSNumber numberWithInt:user.userId],user.userName,[NSNumber numberWithInt:user.userAge],[NSNumber numberWithInt:user.userSex],[NSNumber numberWithInt:user.userDuty]];
    FMDBQuickCheck(worked);
    [db close];
    return worked;
}

/**
 *  获取所有的用户信息
 *
 *  @return 所有用户信息的数组
 */
+(NSMutableArray *)getAllUserInfo
{
    NSMutableArray *userInfoArray=[NSMutableArray array];
    FMDatabase *db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open])
    {
        return userInfoArray;
    }
    [User checkTableCreatedInDb:db];
    
    NSString *queryString=@"SELECT * FROM myUserTable WHERE userId >= ?";
    NSNumber *tpNumber = [NSNumber numberWithInt:0];
    FMResultSet *rs=[db executeQuery:queryString,tpNumber];
    while ([rs next])
    {
        User *tpUser = [[User alloc]init];
        tpUser.userId = [rs intForColumn:@"userId"];
        tpUser.userName = [rs stringForColumn:@"userName"];
        tpUser.userAge = [rs intForColumn:@"userAge"];
        tpUser.userSex = [rs intForColumn:@"userSex"];
        tpUser.userDuty = [rs intForColumn:@"userDuty"];
        [userInfoArray insertObject:tpUser atIndex:0];
    }
    return  userInfoArray;
}

/**
 *  获取用户信息 - 根据用户id
 *
 *  @param id 目标用户的id
 *
 *  @return 指定用户的所有信息
 */

+(NSMutableArray *)getSelectUserById:(int)userId
{
    NSMutableArray *userInfoArray=[NSMutableArray array];
    FMDatabase *db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open])
    {
        return userInfoArray;
    }
    [User checkTableCreatedInDb:db];
    
    NSString *queryString=@"SELECT * FROM myUserTable WHERE userId = ?";
    NSNumber *tempUserId = [NSNumber numberWithInt:userId];
    FMResultSet *rs=[db executeQuery:queryString,tempUserId];
    while ([rs next])
    {
        User *tpUser = [[User alloc]init];
        tpUser.userId = [rs intForColumn:@"userId"];
        tpUser.userName = [rs stringForColumn:@"userName"];
        tpUser.userAge = [rs intForColumn:@"userAge"];
        tpUser.userSex = [rs intForColumn:@"userSex"];
        tpUser.userDuty = [rs intForColumn:@"userDuty"];
        [userInfoArray insertObject:tpUser atIndex:0];
    }
    return  userInfoArray;
}

/**
 *  删除用户信息 - 根据用户id
 *
 *  @param id 目标用户的id
 *
 *  @return YES表示成功，NO表示失败
 */
+(BOOL)deleteUserById:(int)userId
{
    FMDatabase *db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open])
    {
        return NO;
    }
    [User checkTableCreatedInDb:db];
    NSString *insertStr=@"DELETE FROM myUserTable WHERE userId = ?";
    NSNumber *tpUserId = [NSNumber numberWithInt:userId];
    BOOL worked = [db executeUpdate:insertStr,tpUserId];
    FMDBQuickCheck(worked);
    [db close];
    return worked;
}

/**
 *  删除所有的用户信息
 *
 *  @return YES表示删除成功，NO表示删除失败
 */
+(BOOL)deleteAllUser
{
    FMDatabase *db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open])
    {
        return NO;
    }
    [User checkTableCreatedInDb:db];
    NSString *insertStr=@"DELETE FROM myUserTable";
    BOOL worked = [db executeUpdate:insertStr];
    FMDBQuickCheck(worked);
    [db close];
    return worked;
}

/**
 *  更新用户表 - 如果没有表，则创建
 *
 *  @param db 目标db
 *
 *  @return YES表示创建成功，NO表示创建失败
 */
+(BOOL)checkTableCreatedInDb:(FMDatabase *)db
{
    NSString *createStr=@"CREATE TABLE IF NOT EXISTS 'myUserTable' ('userId' VARCHAR,'userName' VARCHAR,'userAge' VARCHAR ,'userSex' VARCHAR, 'userDuty' VARCHAR , PRIMARY KEY('userId'))";
    BOOL worked = [db executeUpdate:createStr];
    FMDBQuickCheck(worked);
    return worked;
}


@end
