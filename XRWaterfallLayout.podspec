Pod::Spec.new do |s|

  s.name         = "XRWaterfallLayout"
  s.version      = "0.1.2"
  s.summary      = "a simple waterfall flow layout"

  s.homepage     = "https://github.com/codingZero/XRWaterfallLayout"

  s.license      = "MIT"

  s.author       = { "codingZero" => "yd13150@vip.qq.com" }

  s.social_media_url ="http://www.jianshu.com/users/425e4eed60ca/latest_articles"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/codingZero/XRWaterfallLayout.git", :tag => s.version }


  s.source_files  = "XRWaterfallLayout/*.{h,m}"

  s.requires_arc = true

end
