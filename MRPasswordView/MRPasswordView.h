//
//  MRPasswordView.h
//  
//
//  Created by Roy on 2017/12/26.
//  Copyright © 2017年 Roy.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    /**
     *  明文 -> 123456
     */
    MRPasswordTypeExpress,
    /**
     *  密文 -> ******
     */
    MRPasswordTypeCiphertext,
} MRPasswordType;

@class MRPasswordView;

@protocol MRPasswordViewDelegate<NSObject>

@optional

/**
 监听输入的改变
 
 @param passWord 密码框
 */
- (void)passWordDidChange:(MRPasswordView *)passWord;

/**
 监听输入的完成时
 
 @param passWord 密码框
 */
- (void)passWordCompleteInput:(MRPasswordView *)passWord;

/**
 监听开始

 @param passWord 密码框
 */
- (void)passWordBeginInput:(MRPasswordView *)passWord;

@end

IB_DESIGNABLE

@interface MRPasswordView : UIView<UIKeyInput>

/**
 密码的位数
 */
@property (assign, nonatomic) IBInspectable NSUInteger passWordNum;
/**
 正方形的大小
 */
@property (assign, nonatomic) IBInspectable CGFloat squareWidth;
/**
 黑点的半径
 */
@property (assign, nonatomic) IBInspectable CGFloat pointRadius;
/**
 明文数字的字体
 */
@property (assign, nonatomic) IBInspectable  UIFont *textFont;
/**
 间隔的宽度
 */
@property (assign, nonatomic) IBInspectable CGFloat  marginWidth;
/**
 密文光标的宽度
 */
@property (assign, nonatomic) IBInspectable CGFloat cursorWidth;
/**
 边框的颜色
 */
@property (strong, nonatomic) IBInspectable UIColor *rectColor;
/**
 方块的背景颜色
 */
@property (strong, nonatomic) IBInspectable UIColor *squareBgColor;
/**
 光标的颜色
 */
@property (strong, nonatomic) IBInspectable UIColor *cursorColor;
/**
 文字或者密文圆点颜色
 */
@property (strong, nonatomic) IBInspectable UIColor *contentColor;
/**
 保存密码的字符串
 */
@property (strong, nonatomic, readonly) NSMutableString *textStore;

/**
 密码输入代理
 */
@property (weak, nonatomic) IBOutlet id<MRPasswordViewDelegate> passwordDelegate;

/**
 密码文本类型(MRPasswordTypeExpress: 明文, MRPasswordTypeCiphertext: 密文)
 */
@property (assign, nonatomic) MRPasswordType passwordType;

/**
 清空密码框
 */
- (void)cleanPassword;

@end
