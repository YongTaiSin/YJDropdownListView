//
//  ViewController.m
//  YJDropdownListExample
//
//  Created by Jeremiah on 2017/6/8.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//

#import "ViewController.h"
#import "YJDropdownListView.h"
#define KScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kRGBColor(r, g, b)              [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface ViewController ()
@property (nonatomic,weak) UITextField *accountTF;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContentView];
}


- (void)setupContentView
{
    self.view.backgroundColor = kRGBColor(244, 244, 244);
    //loginView
    UIView *loginView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, KScreenWidth-2*10, 0)];
    loginView.backgroundColor = [UIColor whiteColor];
    loginView.layer.cornerRadius = 6;
    [self.view addSubview:loginView];
    
    CGFloat tfHeight = 50.f;
    //登陆账号
    UITextField *accountTF = [self textFieldWithPlaceholder:@"登錄帳號"];
    accountTF.frame = CGRectMake(10, 20, loginView.frame.size.width-2*10, tfHeight);
    [loginView addSubview:accountTF];
    self.accountTF = accountTF;
    //登录密码
    UITextField *passwordTF = [self textFieldWithPlaceholder:@"登錄密碼"];
    passwordTF.frame = CGRectMake(CGRectGetMinX(accountTF.frame), CGRectGetMaxY(accountTF.frame)+20, CGRectGetWidth(accountTF.frame), tfHeight);
    passwordTF.secureTextEntry = YES;
    [loginView addSubview:passwordTF];
    //登錄
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(passwordTF.frame)+40, loginView.frame.size.width-2*20, 40)];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [loginBtn setTitle:@"登錄" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:kRGBColor(85, 197, 205)];
    loginBtn.layer.cornerRadius = 4;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:loginBtn];
    CGRect frame = loginView.frame;
    frame.size.height = CGRectGetMaxY(loginBtn.frame)+20;
    loginView.frame = frame;
    CGPoint center = loginView.center;
    center.y = self.view.center.y;
    loginView.center = center;
}

#pragma mark - methods
- (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder
{
    UITextField *textField = [[UITextField alloc]init];
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:18];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    return textField;
}

//方式一 使用默认样式 只指定数据源
- (void)showDropDownlist1
{
    YJDropdownListView *listView = [YJDropdownListView dropDownListView];
    NSArray *arr = @[@"haha",@"hehe",@"heoheo"];
    listView.items(^NSArray<NSString *> *{
        return arr;
    }).didSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath) {
        NSLog(@"hehe");
    }).showOnSuperview(self.accountTF);
}
//方式二 自定义cell样式
- (void)showDropDownlist2
{
    YJDropdownListView *listView = [YJDropdownListView dropDownListView];
    listView.borderColor = kRGBColor(230,230,230);
    listView.borderWidth = 1;
    listView.borderPosition = YJListViewBorderLeft | YJListViewBorderRight | YJListViewBorderBottom;
    listView.maxHeight = 300;
    listView.offsetY = -5;
    listView.separatorColor = [UIColor redColor];
    listView.showSeparatorLine = YES;
    listView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    NSArray *arr = @[@"haha",@"hehe",@"heoheo"];
    listView.numberOfRowsInSection(^NSInteger(NSInteger section) {
        return arr.count;
    }).cellForRowAtIndexPath(^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.text = arr[indexPath.row];
        return cell;
    }).heightForRowAtIndexPath(^CGFloat(NSIndexPath *indexPath) {
        return 50.f;
    }).showOnSuperview(self.accountTF).didSelectRowAtIndexPath(^void (UITableView *tableView,NSIndexPath *indexPath)
                                                               {
                                                                   NSLog(@"哈哈");
                                                               });
}
#pragma mark - handler
#pragma mark 登录事件
- (void)loginClicked:(UIButton *)sender {
    [self showDropDownlist2];
}
@end
