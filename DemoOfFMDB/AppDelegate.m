//
//  AppDelegate.m
//  DemoOfFMDB
//
//  Created by 蔡成汉 on 15/2/28.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FMDBConfig.h"

@interface AppDelegate ()<UIAlertViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //在程序的入口，需要对userName.db进行更新，无论本地是否已经存在这张表。 -- 这个方法最好写成类方法，防止appDelegate文件臃肿
    [self upDateDB];
    
    ViewController *viewController = [[ViewController alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:viewController];
    self.window.rootViewController = navigationController;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 *  更新userName.db
 */
-(void)upDateDB
{
    //先删除程序中的tpUserName.db -- 通过文件管理器
    BOOL canRemoFile;
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:tpUserName_Path];
    if (exist == YES)
    {
        [fileManager removeItemAtPath:tpUserName_Path error:&error];
        if (error != nil)
        {
            canRemoFile = NO;
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"文件删除失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];
            myAlertView.tag = 100;
            [myAlertView show];
        }
        else
        {
            //文件删除成功
            canRemoFile = YES;
        }
    }
    else
    {
        //文件不存在，则执行文件复制
        canRemoFile = YES;
    }
    if (canRemoFile == YES)
    {
        //获取userName的文件路径
        NSString *dbPathString = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"userName.db"];
        
        //进行文件拷贝
        [fileManager copyItemAtPath:dbPathString toPath:tpUserName_Path error:&error];
        if (error != nil)
        {
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"文件更新失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];
            myAlertView.tag = 200;
            [myAlertView show];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        //重试 -- 方法重调
        [self upDateDB];
    }
}

@end
