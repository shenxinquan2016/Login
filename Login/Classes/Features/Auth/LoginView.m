//
//  LoginView.m
//  Login
//
//  Created by 沈昕权 on 16/7/6.
//  Copyright © 2016年 沈昕权. All rights reserved.
//

#import "LoginView.h"
#import <Masonry/View+MASAdditions.h>
#import <BFPaperButton/BFPaperButton.h>

@interface LoginView ()

@property (assign, nonatomic) BOOL didSetupConstaints;//是否建立约束
@property (strong, nonatomic) UITextField *userTextField;//用户名
@property (strong, nonatomic) UITextField *pwdTextField;//密码
@property (strong, nonatomic) BFPaperButton *loginButton;//登录按钮
@property (strong, nonatomic) BFPaperButton *registButton;//注册按钮


@end

@implementation LoginView

- (instancetype)init {
  if (self = [super init]) {
    [self setupViews];
    self.backgroundColor = [UIColor clearColor];
  }
  return self;
}

- (void)setupViews {
  [self addSubview:self.userTextField];
  [self addSubview:self.pwdTextField];
  [self addSubview:self.loginButton];
  [self addSubview:self.registButton];
}

- (void)updateConstraints {
  if (!self.didSetupConstaints) {
    self.didSetupConstaints = YES;
    
    [self.userTextField mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.mas_equalTo(self.mas_top).offset(100);
      make.left.mas_equalTo(40);
      make.right.mas_equalTo(-40);
      make.height.mas_equalTo(40);
    }];
    
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.mas_equalTo(self.userTextField.mas_bottom).offset(10);
      make.left.mas_equalTo(40);
      make.right.mas_equalTo(-40);
      make.height.mas_equalTo(40);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.mas_equalTo(self.pwdTextField.mas_bottom).offset(20);
      make.left.mas_equalTo(self.pwdTextField.mas_left);
      make.size.mas_equalTo(CGSizeMake(130, 40));
    }];
    
    [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.mas_equalTo(self.pwdTextField.mas_bottom).offset(20);
      make.right.mas_equalTo(self.pwdTextField.mas_right);
      make.size.mas_equalTo(CGSizeMake(130, 40));
    }];
    
  }
  [super updateConstraints];
}

- (BFPaperButton *)registButton {
  if (!_registButton) {
    _registButton = [[BFPaperButton alloc] init];
    _registButton.layer.masksToBounds = YES;
    _registButton.layer.cornerRadius = 5;
    _registButton.shadowColor = [UIColor clearColor];
    [_registButton setTitleFont:[UIFont systemFontOfSize:15]];
    _registButton.backgroundColor = [UIColor redColor];
    [_registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_registButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registButton addTarget:self action:@selector(didRegistButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _registButton;
}

- (BFPaperButton *)loginButton {
  if (!_loginButton) {
    _loginButton = [[BFPaperButton alloc] init];
    _loginButton.layer.masksToBounds = YES;
    _loginButton.layer.cornerRadius = 5;
    _loginButton.shadowColor = [UIColor clearColor];
    [_loginButton setTitleFont:[UIFont systemFontOfSize:15]];
    _loginButton.backgroundColor = [UIColor redColor];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(didLoginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
  }
  return _loginButton;
}

- (UITextField *)pwdTextField {
  if (!_pwdTextField) {
    _pwdTextField = [[UITextField alloc] init];
    _pwdTextField.placeholder = @"请输入密码";
    _pwdTextField.backgroundColor = [UIColor whiteColor];
    _pwdTextField.alpha = 0.5;
    _pwdTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdTextField.borderStyle = UITextBorderStyleNone;
    _pwdTextField.layer.cornerRadius = 5;
    _pwdTextField.font = [UIFont systemFontOfSize:15];
    _pwdTextField.textColor = [UIColor blackColor];
    _pwdTextField.secureTextEntry = YES;
    
  }
  return _pwdTextField;
}

- (UITextField *)userTextField {
  if (!_userTextField) {
    _userTextField = [[UITextField alloc] init];
    _userTextField.placeholder = @"请输入用户名";
    _userTextField.backgroundColor = [UIColor whiteColor];
    _userTextField.alpha = 0.5;
    _userTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userTextField.borderStyle = UITextBorderStyleNone;
    _userTextField.layer.cornerRadius = 5;
    _userTextField.font = [UIFont systemFontOfSize:15];
    _userTextField.textColor = [UIColor blackColor];
    
  }
  return _userTextField;
}

#pragma mark -
- (void)didRegistButtonClicked:(id)sender {
  if (self.delegate && [self.delegate respondsToSelector:@selector(didRegistButtonClicked)]) {
    [self.delegate didRegistButtonClicked];
  }
}

- (void)didLoginButtonClicked {
  //将手机号保存到沙盒
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:_userTextField.text forKey:@"user"];
  [defaults synchronize];
  
  if (self.delegate && [self.delegate respondsToSelector:@selector(didLoginButtonClicked:pwd:)]) {
    [self.delegate didLoginButtonClicked:self.userTextField.text pwd:self.pwdTextField.text];
  }
}

@end
