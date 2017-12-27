
Pod::Spec.new do |s|

  s.name         = "MRPasswordView"
  s.version      = "0.4.0"
  s.summary      = "仿支付宝支付密码文本框效果."
  s.description  = <<-DESC
                   本着学习、研究的态度，仿制密码文本框效果；在一些已有博客进行优化，满足需求。
                   V 1.0 init；
                   V 2.0 增加清除密码方法；
                   V 3.0 修改；
                   V 4.0 支持下划线样式；
                   DESC
  s.homepage     = "https://github.com/CrazyRoy/MRPasswordView"
  s.screenshots  = "https://github.com/CrazyRoy/MRPasswordView/blob/master/screenshot.png"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author       = { "CrazyRoy" => "897323459@qq.com" }
  s.platform     = :ios
  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/CrazyRoy/MRPasswordView.git", :tag => "#{s.version}" }

  s.source_files  = "MRPasswordView/**/*.{jpg,png}", "MRPasswordView/**/*.{h,m}"

  s.requires_arc = true

end