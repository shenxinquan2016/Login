//
//  LoginView.h
//  Login
//
//  Created by 沈昕权 on 16/7/6.
//  Copyright © 2016年 沈昕权. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>

- (void)didLoginButtonClicked:(NSString *)user pwd:(NSString *)pwd;
- (void)didRegistButtonClicked;

@end

@interface LoginView : UIView

@property (weak, nonatomic) id <LoginViewDelegate> delegate;

@end
