//
//  MRPasswordView.m
//
//
//  Created by Roy on 2017/12/26.
//  Copyright © 2017年 Roy.com. All rights reserved.
//

#import "MRPasswordView.h"

@interface MRPasswordView()

/**
 保存密码的字符串
 */
@property (strong, nonatomic) NSMutableString *textStore;

@end

@implementation MRPasswordView

static NSString  * const KMONEYNUMBERS = @"0123456789";

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initData];
    }
    return self;
}

/**
 初始化默认数据
 */
- (void)initData
{
    self.backgroundColor = [UIColor clearColor];
    self.textStore = [NSMutableString string];
    self.squareWidth = 50;
    self.passWordNum = 6;
    self.pointRadius = 6;
    self.cursorWidth = 1.5f;
    self.rectColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    self.contentColor = [UIColor blackColor];
    self.cursorColor = self.rectColor;
    [self becomeFirstResponder];
}

/**
 设置间距

 @param marginWidth 间距值
 */
- (void)setMarginWidth:(CGFloat)marginWidth
{
    _marginWidth = marginWidth;
    self.squareWidth = (self.frame.size.width - (self.passWordNum+1)*_marginWidth)/self.passWordNum;
    [self setNeedsDisplay];
}

/**
 *  设置键盘的类型
 */
- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumberPad;
}

/**
 *  设置密码的位数
 */
- (void)setPassWordNum:(NSUInteger)passWordNum {
    _passWordNum = passWordNum;
    [self setNeedsDisplay];
}

- (BOOL)becomeFirstResponder {
    if ([self.passwordDelegate respondsToSelector:@selector(passWordBeginInput:)]) {
        [self.passwordDelegate passWordBeginInput:self];
    }
    return [super becomeFirstResponder];
}

/**
 *  是否能成为第一响应者
 */
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (![self isFirstResponder]) {
        [self becomeFirstResponder];
    }
}

#pragma mark - UIKeyInput
/**
 *  用于显示的文本对象是否有任何文本
 */
- (BOOL)hasText {
    return self.textStore.length > 0;
}

/**
 *  插入文本
 */
- (void)insertText:(NSString *)text {
    if (self.textStore.length < self.passWordNum) {
        //判断是否是数字
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:KMONEYNUMBERS] invertedSet];
        NSString*filtered = [[text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [text isEqualToString:filtered];
        if(basicTest) {
            [self.textStore appendString:text];
            if ([self.passwordDelegate respondsToSelector:@selector(passWordDidChange:)]) {
                [self.passwordDelegate passWordDidChange:self];
            }
            if (self.textStore.length == self.passWordNum) {
                if ([self.passwordDelegate respondsToSelector:@selector(passWordCompleteInput:)]) {
                    [self.passwordDelegate passWordCompleteInput:self];
                }
            }
            [self setNeedsDisplay];
        }
    }
}

/**
 *  删除文本
 */
- (void)deleteBackward {
    if (self.textStore.length > 0) {
        [self.textStore deleteCharactersInRange:NSMakeRange(self.textStore.length - 1, 1)];
        if ([self.passwordDelegate respondsToSelector:@selector(passWordDidChange:)]) {
            [self.passwordDelegate passWordDidChange:self];
        }
    }
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
- (void)drawRect:(CGRect)rect {
    CGFloat height = rect.size.height;
    CGFloat width = rect.size.width;
    CGFloat x = (width - self.squareWidth*self.passWordNum)/2.0;
    CGFloat y = (height - self.squareWidth)/2.0;
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画外框
    CGContextAddRect(context, CGRectMake( x, y, self.squareWidth*self.passWordNum, self.squareWidth));
    CGContextSetLineWidth(context, self.marginWidth);
    CGContextSetStrokeColorWithColor(context, self.rectColor.CGColor);
    CGContextSetFillColorWithColor(context, self.squareBgColor.CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //画竖条
    for (int i = 1; i < self.passWordNum; i++) {
        CGContextMoveToPoint(context, x+i*self.squareWidth, y);
        CGContextAddLineToPoint(context, x+i*self.squareWidth, y+self.squareWidth);
        CGContextSetLineWidth(context, self.marginWidth);
        CGContextSetStrokeColorWithColor(context, self.rectColor.CGColor);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    
    //画占位符
    switch (self.passwordType) {
        case MRPasswordTypeExpress:
            {
                for (int i = 1; i <= self.textStore.length; i++) {
                    NSString *str = [self.textStore substringWithRange:NSMakeRange(i-1, 1)];
                    //段落格式
                    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
                    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                    textStyle.alignment = NSTextAlignmentCenter;//水平居中
                    //字体
                    UIFont *font = self.textFont ? self.textFont : [UIFont systemFontOfSize:[UIFont systemFontSize]];
                    //构建属性集合
                    NSDictionary *attributes = @{
                                                 NSFontAttributeName:font,
                                                 NSParagraphStyleAttributeName:textStyle,
                                                 NSForegroundColorAttributeName:self.contentColor
                                                 };
                    //获得size
                    CGSize strSize = [str sizeWithAttributes:attributes];
                    if(strSize.width > self.squareWidth || strSize.height > self.squareWidth)
                    {
                        strSize = CGSizeMake(self.squareWidth, self.squareWidth);
                    }
                    CGFloat marginTop = (self.squareWidth - strSize.height)/2;
                    //垂直居中要自己计算
                    CGRect rect = CGRectMake(x + (i-1)*self.squareWidth + self.squareWidth*0.5 - strSize.width*0.5, y + marginTop, strSize.width, strSize.height);
                    [str drawInRect:rect withAttributes:attributes];
                }
            }
            break;
        case MRPasswordTypeCiphertext:
            {
                for (int i = 1; i <= self.textStore.length; i++) {
                    CGContextAddArc(context,  x+i*self.squareWidth - self.squareWidth/2.0, y+self.squareWidth/2, self.pointRadius, 0, M_PI*2, YES);
                    CGContextSetFillColorWithColor(context, self.contentColor.CGColor);
                    CGContextDrawPath(context, kCGPathFill);
                }
            }
            break;
        default:
            break;
    }

    //画光标
    if(self.textStore.length < self.passWordNum)
    {
        NSInteger index = self.textStore.length;
        if(index >= 0)
        {
            CGContextMoveToPoint(context, x + self.squareWidth*index + (self.squareWidth*0.5 - self.cursorWidth*0.5), y+self.squareWidth*0.25);
            CGContextAddLineToPoint(context, x + self.squareWidth*index + (self.squareWidth*0.5 - self.cursorWidth*0.5), y+self.squareWidth*0.75);
            CGContextSetLineWidth(context, self.cursorWidth);
            CGContextSetStrokeColorWithColor(context, self.cursorColor.CGColor);
            CGContextClosePath(context);
            CGContextDrawPath(context, kCGPathFillStroke);
        }
    }
}

@end
