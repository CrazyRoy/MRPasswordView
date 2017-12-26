# MRPasswordView
 
### Podfile
To integrate MRPasswordView into your Xcode project using CocoaPods, specify it in your `Podfile`:

```objc
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'MRPasswordView', '~> 0.1'
end
```

Then, run the following command:

```ruby
$ pod install
```

### Used

First:

```objc
#import "MRPasswordView.h"
```

Then:

```objc
MRPasswordView *passwordView = [[MRPasswordView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-300)/2, 200, 300, 60)];
passwordView.passwordType = MRPasswordTypeExpress;
passwordView.marginWidth = 5.f;
passwordView.rectColor = [UIColor grayColor];
passwordView.squareBgColor = [UIColor whiteColor];
passwordView.textFont = [UIFont systemFontOfSize:20.f];
passwordView.passwordDelegate = self;
passwordView.cursorColor = [UIColor grayColor];
[self.view addSubview:passwordView];

```

> so easy for you used!!!
