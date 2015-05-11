//
//  ViewController.m
//  DemoOfFMDB
//
//  Created by 蔡成汉 on 15/2/28.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "ViewController.h"
#import "BasicUserInfoTableViewCell.h"
#import "FMDBConfig.h"
#import "User.h"
#import "FMDB.h"
#import "UserInfoViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    /**
     *  用户信息列表 -- 数据来自于DB
     */
    NSMutableArray *userInfoArray;
    
    /**
     *  用户信息展示表
     */
    UITableView *myTableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"用户信息";
    [self initiaNav];
    
    if ([[UIDevice currentDevice] systemVersion].floatValue>=7.0)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //从DB中获取用户信息
    userInfoArray = [User getAllUserInfo];
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    [self.view addSubview:myTableView];
}

-(void)initiaNav
{
    //左边清空用户
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"清空用户" style:UIBarButtonItemStylePlain target:self action:@selector(clearUser)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右边生成新用户
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"生成新用户" style:UIBarButtonItemStylePlain target:self action:@selector(addUser)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return userInfoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    BasicUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[BasicUserInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //调用方法，进行数据分发
    [cell setBasicUserInfoTableViewCellWithUser:[userInfoArray objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UserInfoViewController *viewController = [[UserInfoViewController alloc]init];
    viewController.currentUser = [userInfoArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//修改删除按钮的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //从DB表中删除用户信息
    BOOL isSuccess = [User deleteUserById:(int)indexPath.row];
    if (isSuccess == YES)
    {
        [userInfoArray removeObjectAtIndex:indexPath.row];
        NSIndexPath *tpIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        NSArray *indexPathArray = [NSArray arrayWithObjects:tpIndexPath, nil];
        [myTableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationRight];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"删除失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertView show];
    }
}


/**
 *  向DB表中添加一个新的用户
 */
-(void)addUser
{
    //创建user对象
    User *tpUser = [self creatUser];
    
    //需要将生成的用户保存到DB中
    [User saveUser:tpUser];
    
    //进行tableview进行操作 -- 插入一条用户信息
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSArray *indexPathArray = [NSArray arrayWithObjects:indexPath, nil];
    [myTableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationLeft];
}

/**
 *  随机生成一个新的用户
 */
-(User *)creatUser
{
    User *tpUser = [[User alloc]init];
    FMDatabase *db = [FMDatabase databaseWithPath:tpUserName_Path];
    if (![db open])
    {
        return nil;
    }
    //用户id具有唯一性，所以不能随机生成
    tpUser.userId = (int)userInfoArray.count;
    
    //获取用户名
    //从DB中依次随机获取用户的firstName、midlelName、lastName -- 采用一个循环
    NSString *nameString = @"";
    for (int i = 0; i<3; i++)
    {
        //获取一个行号id的随机数
        int x = arc4random()%15;
        NSString *idString = [NSString stringWithFormat:@"%d",x];
        
        NSString *queryString = @"SELECT * FROM userNameTable WHERE id = ?";
        FMResultSet *rs=[db executeQuery:queryString,idString];
        
        //执行查询结果语句
        while ([rs next])
        {
            NSString *tpNameString;
            //第一次获取firstName，第二次获取midlelName，第三次获取lastName
            if (i == 0)
            {
                //获取firstName，然后进行字符串拼接
                tpNameString = [rs stringForColumn:@"firstName"];
            }
            else if (i == 1)
            {
                //获取midlelName，然后进行字符串拼接
                tpNameString = [rs stringForColumn:@"midleName"];
                if (tpNameString == nil)
                {
                    tpNameString = @"";
                }
                
            }
            else
            {
                //获取lastName，然后进行字符串拼接
                tpNameString = [rs stringForColumn:@"lastName"];
            }
            nameString = [nameString stringByAppendingString:tpNameString];
        }
    }
    [db close];
    
    tpUser.userName = nameString;
    
    //随机生成一个userAge 15~30；
    int age = 15 + (arc4random()%15);
    tpUser.userAge = age;
    
    int sex = (arc4random()%2);
    if (sex == 0)
    {
        tpUser.userSex = UserSexBoy;
    }
    else
    {
        tpUser.userSex = UserSexGirl;
    }
    
    //随机生成职位 - 学生、开发者、工人
    int duty = (arc4random()%3);
    if (duty == 0)
    {
        tpUser.userDuty = UserDutyStudent;
    }
    else if (duty == 1)
    {
        tpUser.userDuty = UserDutyDevelopers;
    }
    else
    {
        tpUser.userDuty = UserDutyWorkers;
    }
    
    //需要将新生成的用户添加到用户信息数组中
    [userInfoArray insertObject:tpUser atIndex:0];
    return tpUser;
}

-(void)clearUser
{
    [User deleteAllUser];
    [userInfoArray removeAllObjects];
    [myTableView reloadData];
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
