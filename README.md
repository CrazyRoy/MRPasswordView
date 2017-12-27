# MRPasswordView

![screenshot](https://github.com/CrazyRoy/MRPasswordView/blob/master/screenshot.png)
 
### Podfile
To integrate MRPasswordView into your Xcode project using CocoaPods, specify it in your `Podfile`:

```objc
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'MRPasswordView'
end
```

Then, run the following command:

```ruby
$ pod install
```

### Used

First:

```objc
#import <MRPasswordView/MRPasswordView.h>
```

Then:

```objc
// init
MRPasswordView *passwordView = [[MRPasswordView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-300)/2, 200, 300, 60)];
passwordView.passwordType = MRPasswordTypeExpress;
passwordView.marginWidth = 5.f;
passwordView.rectColor = [UIColor grayColor];
passwordView.squareBgColor = [UIColor whiteColor];
passwordView.textFont = [UIFont systemFontOfSize:20.f];
passwordView.passwordDelegate = self;
passwordView.cursorColor = [UIColor grayColor];
[self.view addSubview:passwordView];

#pragma mark - MRPasswordViewDelegate 代理

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

```

> so easy for you use it !!!
