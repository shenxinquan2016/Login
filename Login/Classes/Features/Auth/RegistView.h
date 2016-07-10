//
//  RegistView.h
//  Login
//
//  Created by 沈昕权 on 16/7/6.
//  Copyright © 2016年 沈昕权. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegistViewDelegate <NSObject>
- (void)didRegistButtonClicked:(NSString *)user pwd:(NSString *)pwd repeatPwd:(NSString *)repeatPwd;
@end

@interface RegistView : UIView

@property (weak, nonatomic) id <RegistViewDelegate> delegate;

@end
