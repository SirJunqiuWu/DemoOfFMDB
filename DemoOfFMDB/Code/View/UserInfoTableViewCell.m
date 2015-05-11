//
//  UserInfoTableViewCell.m
//  DemoOfFMDB
//
//  Created by 蔡成汉 on 15/3/3.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "UserInfoTableViewCell.h"

@implementation UserInfoTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initiaUserInfoTableViewCell];
    }
    return self;
}

-(void)initiaUserInfoTableViewCell
{
    //keyLabel
    self.keyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width*1/3 - 20, 44)];
    self.keyLabel.backgroundColor = [UIColor clearColor];
    self.keyLabel.textColor = [UIColor blueColor];
    self.keyLabel.textAlignment = NSTextAlignmentLeft;
    self.keyLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:self.keyLabel];
    
    //valLabel
    self.valLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*1/3, 0, [UIScreen mainScreen].bounds.size.width*2/3 - 20, 44)];
    self.valLabel.backgroundColor = [UIColor clearColor];
    self.valLabel.textColor = [UIColor redColor];
    self.valLabel.textAlignment = NSTextAlignmentRight;
    self.valLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:self.valLabel];
    
}

/**
 *  对外方法，用户获取用户信息 -- 需要tag值和val值
 *
 *  @param tag tag值，用来区分用户的哪一条信息，用于给keyLabel赋值
 *  @param user user值，用户信息
 */
-(void)setUserInfoTableViewCellWithTag:(NSInteger)tag user:(User *)user
{
    //数据获取
    if (tag == 0)
    {
        self.keyLabel.text = @"用户id：";
        self.valLabel.text = [NSString stringWithFormat:@"%d",user.userId];
    }
    else if (tag == 1)
    {
        self.keyLabel.text = @"用户名：";
        self.valLabel.text = [NSString stringWithFormat:@"%@",user.userName];
    }
    else if (tag == 2)
    {
        self.keyLabel.text = @"年龄：";
        self.valLabel.text = [NSString stringWithFormat:@"%d",user.userAge];
    }
    else if (tag == 3)
    {
        self.keyLabel.text = @"性别：";
        UserSex tpSex = user.userSex;
        if (tpSex == UserSexBoy)
        {
            self.valLabel.text = @"男";
        }
        else
        {
            self.valLabel.text = @"女";
        }
    }
    else
    {
        self.keyLabel.text = @"职位：";
        UserDuty tpDuty = user.userDuty;
        if (tpDuty == UserDutyStudent)
        {
            self.valLabel.text = @"学生";
        }
        else if (tpDuty == UserDutyDevelopers)
        {
            self.valLabel.text = @"开发者";
        }
        else
        {
            self.valLabel.text = @"工人";
        }
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
