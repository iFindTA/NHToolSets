Pod::Spec.new do |s|

  s.name         = "NHToolSets"
  s.version      = "0.2.1"
  s.summary      = "NHToolSets is an Objc Wrapper Kit foriOS Developers."
  s.homepage     = "https://github.com/iFindTA"
  s.description  = "iOS Developer's Common Kit Sets, the commands between Foundation and UIKit frameworks."
  s.license      = {:type => 'MIT', :file => 'LICENSE'}
  s.author             = { "hujiaju" => "nanhujiaju@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/iFindTA/NHToolSets.git", :tag => s.version.to_s }
  s.source_files  = "NHUtilSetsPro/Utils/*.{h,m}"
  s.public_header_files = "NHUtilSetsPro/Utils/*.h"

  s.framework  = "UIKit","Foundation","Accelerate","QuartzCore","CoreText"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  s.requires_arc = true
  # s.dependency "JSONKit", "~> 1.4"

end
