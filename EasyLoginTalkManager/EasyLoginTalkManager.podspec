Pod::Spec.new do |spec|

  spec.name         = "EasyLoginTalkManager"
  spec.version      = "1.0.0"
  spec.summary      = "Best framework login talk"
  
  spec.description  = <<-DESC
        When I was a boy.
        This is best framework login talk.
                   DESC
                   
  spec.homepage     = "https://github.com/trung10101995/EasyLoginTalk"
  spec.license      = "MIT"
  spec.author             = { "TrungCrit" => "Trung10101995@gmail.com" }
  
  spec.platform     = :ios, "11.0"
  spec.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
  spec.source       = { :git => "https://github.com/trung10101995/EasyLoginTalk.git", :tag => "1.0.0" }
  
  spec.source_files = "EasyLoginTalkManager/**/*.{h,m,swift,xib}"
  spec.resources  = "EasyLoginTalkManager/**/*.xcassets"
  
  spec.dependency 'MLTransition'
  spec.dependency 'PinCodeTextField'
  spec.dependency 'ReachabilitySwift'
  spec.dependency 'ObjectMapper'
  
end
