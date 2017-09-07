Pod::Spec.new do |s|

  s.name         = "PBKits"
  s.version      = "1.2.0"
  s.summary      = "PBKits is an Objc Wrapper Kit for iOS Developers."
  s.homepage     = "https://github.com/iFindTA"
  s.description  = "iOS Developer's Common Kit Sets, the commands between Foundation and UIKit frameworks."
  s.license      = {:type => 'MIT', :file => 'LICENSE'}
  s.author             = { "hujiaju" => "nanhujiaju@gmail.com" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/iFindTA/NHToolSets.git", :tag => s.version.to_s }
  s.source_files  = "NHUtilSetsPro/Utils/*.{h,m}"
  s.public_header_files = "NHUtilSetsPro/Utils/*.h"
  
  #s.library	= "CommonCrypto"
  s.framework  = "UIKit","Foundation","Accelerate","QuartzCore","CoreText"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  s.requires_arc = true

   #s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/CommonCrypto,$(SRCROOT)/FLKNetService/Core","CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES" =>"YES","ONLY_ACTIVE_ARCH" => "NO"}
  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include","CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES" =>"YES","ONLY_ACTIVE_ARCH" => "NO"}

  # s.dependency "JSONKit", "~> 1.4"

end
