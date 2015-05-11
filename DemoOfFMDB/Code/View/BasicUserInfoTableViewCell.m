//
//  BasicUserInfoTableViewCell.m
//  DemoOfFMDB
//
//  Created by 蔡成汉 on 15/2/28.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "BasicUserInfoTableViewCell.h"

@implementation BasicUserInfoTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initiaBasicUserInfoTableViewCell];
    }
    return self;
}

-(void)initiaBasicUserInfoTableViewCell
{
    //userNameLabel
    self.userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width*2/3 - 20, 44)];
    self.userNameLabel.backgroundColor = [UIColor clearColor];
    self.userNameLabel.textColor = [UIColor blackColor];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    self.userNameLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:self.userNameLabel];
    
    //userDutyLabel
    self.userDutyLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*2/3, 0, [UIScreen mainScreen].bounds.size.width*1/3 - 20, 44)];
    self.userDutyLabel.backgroundColor = [UIColor clearColor];
    self.userDutyLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
    self.userDutyLabel.textAlignment = NSTextAlignmentRight;
    self.userDutyLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.userDutyLabel];
}

/**
 *  对外方法，用于cell上的获取用户信息
 *
 *  @param user cell上的用户信息
 */
-(void)setBasicUserInfoTableViewCellWithUser:(User *)user
{
    //获取用户名
    self.userNameLabel.text = user.userName;
    
    //获取用户职位
    if (user.userDuty == UserDutyStudent)
    {
        self.userDutyLabel.text = @"学生";
    }
    else if (user.userDuty == UserDutyDevelopers)
    {
        self.userDutyLabel.text = @"开发者";
    }
    else
    {
        self.userDutyLabel.text = @"工人";
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
