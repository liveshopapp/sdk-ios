Pod::Spec.new do |s|

  s.name                = "liveshop"
  s.version             = "1.0.0"
  s.summary             = "123"
  s.description         = "456"
  s.homepage            = "789"
  s.license             = "MIT"
  s.author              = "Renan Kosicki"
  s.platform            = :ios, "10.0"
  s.source              = { :git => "https://github.com/liveshopapp/sdk-ios.git", :tag => "1.0.0" }
  s.source_files        = "liveshop/**/*.{png,lproj,storyboard,swift,xib}"
  s.swift_version       = "4.0"
  s.ios.vendored_frameworks = 'liveshop/IJKMediaFramework.framework'
  s.vendored_frameworks = 'liveshop/IJKMediaFramework.framework'
  s.resource = 'liveshop/IJKMediaFramework.framework'
  s.public_header_files =
  s.dependency 'Alamofire'
  s.dependency 'Socket.IO-Client-Swift'
  s.dependency 'LFLiveKit'
  s.dependency 'IHKeyboardAvoiding'
  # s.dependency 'lottie-ios'
  s.dependency 'SVProgressHUD'
  s.dependency 'Validator'
  # s.dependency 'SwiftMessages'

end
