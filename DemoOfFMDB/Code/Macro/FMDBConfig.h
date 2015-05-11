//
//  FMDBConfig.h
//  DemoOfFMDB
//
//  Created by 蔡成汉 on 15/2/28.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#ifndef DemoOfFMDB_FMDBConfig_h
#define DemoOfFMDB_FMDBConfig_h

#import "FMDB.h"

//FMDB
#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }

#define DATABASE_PATH [NSString stringWithFormat:@"%@/Documents/userInfo.db", NSHomeDirectory()]

#define tpUserName_Path [NSString stringWithFormat:@"%@/Documents/tpUserName.db", NSHomeDirectory()]

#endif
