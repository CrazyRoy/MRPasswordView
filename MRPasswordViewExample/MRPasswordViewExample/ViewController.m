//
//  ViewController.m
//  MRPasswordViewExample
//
//  Created by Roy on 2017/12/26.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "ViewController.h"
#import "MRPasswordView.h"

@interface ViewController ()<MRPasswordViewDelegate>

@property (nonatomic, strong) MRPasswordView *passwordView;

@property (nonatomic, strong) MRPasswordView *passwordView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-300)/2, 100, 300, 30)];
    label1.text = @"明文";
    label1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label1];
    
    // 明文
    self.passwordView.passwordType = MRPasswordTypeExpress;
    self.passwordView.marginWidth = 9.f;
    self.passwordView.rectColor = [UIColor clearColor];
    self.passwordView.squareBgColor = [UIColor clearColor];
    self.passwordView.textFont = [UIFont boldSystemFontOfSize:24.f];
    self.passwordView.passwordDelegate = self;
    self.passwordView.cursorColor = [UIColor orangeColor];
    self.passwordView.cursorWidth = 2.f;
    self.passwordView.underlineColor = [UIColor blackColor];
    [self.view addSubview:self.passwordView];
    
    [super viewDidLoad];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-300)/2, 270, 300, 30)];
    label2.text = @"密文";
    label2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label2];
    // 密文
    self.passwordView2.passwordType = MRPasswordTypeCiphertext;
    self.passwordView2.marginWidth = 5.f;
    self.passwordView2.rectColor = [UIColor redColor];
    self.passwordView2.squareBgColor = [UIColor whiteColor];
    self.passwordView2.contentColor = [UIColor redColor];
    self.passwordView2.textFont = [UIFont systemFontOfSize:20.f];
    self.passwordView2.passwordDelegate = self;
    self.passwordView2.cursorColor = [UIColor redColor];
    [self.view addSubview:self.passwordView2];
}

- (MRPasswordView *)passwordView
{
    if(!_passwordView)
    {
        _passwordView = [[MRPasswordView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-350)/2, 130, 350, 60)];
    }
    return _passwordView;
}

- (MRPasswordView *)passwordView2
{
    if(!_passwordView2)
    {
        _passwordView2 = [[MRPasswordView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-300)/2, 300, 300, 60)];
    }
    return _passwordView2;
}

#pragma mark - MRPasswordViewDelegate

/**
 *  监听输入的改变
 */
- (void)passWordDidChange:(MRPasswordView *)passWord {
    NSLog(@"======密码改变：%@",passWord.textStore);
}

/**
 *  监听输入的完成时
 */
- (void)passWordCompleteInput:(MRPasswordView *)passWord {
    NSLog(@"+++++++密码输入完成");
}

/**
 *  监听开始输入
 */
- (void)passWordBeginInput:(MRPasswordView *)passWord {
    NSLog(@"-------密码开始输入");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self.passwordView cleanPassword];
    [self.view endEditing:YES];
}

@end
