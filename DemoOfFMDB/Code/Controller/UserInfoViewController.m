//
//  UserInfoViewController.m
//  DemoOfFMDB
//
//  Created by 蔡成汉 on 15/3/3.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoTableViewCell.h"

@interface UserInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation UserInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.currentUser.userName;
    
    if ([[UIDevice currentDevice] systemVersion].floatValue>=7.0)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //创建用户信息表
    UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    [self.view addSubview:myTableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"userInfoTableViewCell";
    UserInfoTableViewCell *userInfoTableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (userInfoTableViewCell == nil)
    {
        userInfoTableViewCell = [[UserInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    userInfoTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //数据分发
    [userInfoTableViewCell setUserInfoTableViewCellWithTag:indexPath.row user:self.currentUser];
    return userInfoTableViewCell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
