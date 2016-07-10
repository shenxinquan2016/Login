//
//  LoginViewController.m
//  Login
//
//  Created by 沈昕权 on 16/7/6.
//  Copyright © 2016年 沈昕权. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import <Masonry/Masonry.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <StarterKit/SKHTTPSessionManager.h>
#import "RegistViewController.h"
#import <StarterKit/SKToastUtil.h>
#import <AVOSCloud/AVOSCloud.h>

@interface LoginViewController () <LoginViewDelegate>

@property (strong, nonatomic) UIImageView *bgImgView;
@property (strong, nonatomic) LoginView *loginView;
@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.navigationController.navigationBarHidden = YES;
}

#pragma mark - 生命周期方法
- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];
  
  [self.view addSubview:self.bgImgView];
  [self.view addSubview:self.loginView];
  
  [self.view updateConstraintsIfNeeded];
  [self.view setNeedsUpdateConstraints];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma maek - 更新约束
- (void)updateViewConstraints {
  
  UIView *superView = self.view;
  [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(superView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
  }];
  
  [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.bgImgView.mas_top);
    make.leading.mas_equalTo(self.bgImgView.mas_leading);
    make.trailing.mas_equalTo(self.bgImgView.mas_trailing);
    make.bottom.mas_equalTo(self.mas_bottomLayoutGuideBottom);
    
  }];
  [super updateViewConstraints];
}

#pragma mark - 创建控件
//背景图
- (UIImageView *)bgImgView {
  if (!_bgImgView) {
    _bgImgView = [[UIImageView alloc] init];
    _bgImgView.image = [UIImage imageNamed:@"bg"];
  }
  return _bgImgView;
}

//子类化的 LoginView
- (LoginView *)loginView {
  if (!_loginView) {
    _loginView = [[LoginView alloc] init];
    _loginView.delegate = self;
  }
  return _loginView;
}

#pragma mark - 点击方法
//点击登录按钮
- (void)didLoginButtonClicked:(NSString *)user pwd:(NSString *)pwd {
  
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  //登录
  [AVUser logInWithUsernameInBackground:user password:pwd block:^(AVUser *user, NSError *error) {
    if (user != nil) {
      [hud hide:YES];
      [SKToastUtil toastWithText:@"登录成功"];
    } else {
      NSLog(@"error : %@", error);
      
      [hud hide:YES];
      [SKToastUtil toastWithText:@"登录失败"];
    }
  }];
  
}

//点击注册按钮
- (void)didRegistButtonClicked {
  RegistViewController *vcRegist = [[RegistViewController alloc] init];
  [self.navigationController pushViewController:vcRegist animated:YES];
}

#pragma mark - 收起键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.view endEditing:YES];
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
