//
//  RegistViewController.m
//  Login
//
//  Created by 沈昕权 on 16/7/6.
//  Copyright © 2016年 沈昕权. All rights reserved.
//

#import "RegistViewController.h"
#import "RegistView.h"
#import <Masonry/Masonry.h>
#import <StarterKit/SKToastUtil.h>
#import <AVOSCloud/AVOSCloud.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface RegistViewController () <RegistViewDelegate>

@property (strong, nonatomic) UIImageView *bgImgView;//背景
@property (strong, nonatomic) RegistView *registView;

@end

@implementation RegistViewController

#pragma mark - 生命周期方法
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.navigationController.navigationBarHidden = NO;
  self.title = @"注册";
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  
  [self.view addSubview:self.bgImgView];
  [self.view addSubview:self.registView];
  
  [self.view updateConstraintsIfNeeded];
  [self.view setNeedsUpdateConstraints];

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - 更新约束
- (void)updateViewConstraints {
  
  UIView *superView = self.view;
  [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(superView);
    make.leading.mas_equalTo(superView.mas_leading);
    make.trailing.mas_equalTo(superView.mas_trailing);
    make.bottom.mas_equalTo(self.mas_bottomLayoutGuideBottom);
  }];
  
  [self.registView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.bgImgView.mas_top);
    make.leading.mas_equalTo(self.bgImgView.mas_leading);
    make.trailing.mas_equalTo(self.bgImgView.mas_trailing);
    make.bottom.mas_equalTo(self.mas_bottomLayoutGuideBottom);
  }];
  [super updateViewConstraints];
}

#pragma mark - 创建控件
//子类化的 RegistView
- (RegistView *)registView {
  if (!_registView) {
    _registView = [[RegistView alloc] init];
    _registView.delegate = self;
  }
  return _registView;
}

//背景
- (UIImageView *)bgImgView {
  if (!_bgImgView) {
    _bgImgView = [[UIImageView alloc] init];
    _bgImgView.image = [UIImage imageNamed:@"bg"];
  }
  return _bgImgView;
}

#pragma mark - 按钮点击方法
- (void)didRegistButtonClicked:(NSString *)user pwd:(NSString *)pwd repeatPwd:(NSString *)repeatPwd {
  if (user.length <= 3) {
    [SKToastUtil toastWithText:@"用户名不得少于4位"];
    return;
  }
  if (![repeatPwd isEqualToString:pwd]) {
    [SKToastUtil toastWithText:@"两次输入的密码不一致"];
    return;
  }
  
  AVUser *avUser = [AVUser user];// 新建 AVUser 对象实例
  avUser.username = user;// 设置用户名
  avUser.password = pwd;// 设置密码
//  avUser.email = email;// 设置邮箱
  
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  [avUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    if (succeeded) {
      // 注册成功
      [hud hide:YES];
      [SKToastUtil toastWithText:@"注册成功"];
      
    } else {
      // 失败的原因可能有多种，常见的是用户名已经存在。
      [hud hide:YES];
      [SKToastUtil toastWithText:@"注册失败,用户名已存在"];
    }
  }];
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
