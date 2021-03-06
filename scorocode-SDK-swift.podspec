Pod::Spec.new do |s|

  s.name         = "scorocode-SDK-swift"
  s.version      = "1.1.2"
  s.summary      = <<-DESC
                    SDK предоставляет доступ к платформе Scorocode (https://scorocode.ru)\nSDK provides access to Scorocode platform (https://scorocode.ru)
                   DESC

  s.description  = "SDK предоставляет доступ к платформе Scorocode. Подробности на нашем сайте: https://scorocode.ru
                    SDK provides access to Scorocode platform. Details on our site: https://scorocode.ru"

  s.homepage     = "https://github.com/Galeas/scorocode-SDK-swift"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Scorocode" => "info@scorocode.ru" }
  
  s.requires_arc = true
  s.osx.deployment_target = "10.9"
  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/Galeas/scorocode-SDK-swift.git", :tag => s.version }
  s.source_files  = "SC/SCLib/**/*.{h,m,swift}"

  s.dependency "Alamofire", "~> 3.3"
  s.dependency "SwiftyJSON"

end
