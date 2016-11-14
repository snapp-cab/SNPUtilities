Pod::Spec.new do |s|
  s.name             = "SNPDialog"
  s.version          = "1.0.0"
  s.summary          = "Snapp custom dialog"
  s.homepage         = "https://github.com/snapp-cab/snapp-ios-dialog"
  s.license          = 'Snapp license'
  s.author           = { "Nader Rashed" => "nader.rashed@snapp.cab" }
  s.source           = { :git => "git@github.com:snapp-cab/snapp-ios-dialog.git", :tag => s.version }
  s.social_media_url = 'https://snapp.ir'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Classes/*'
  s.resources = 'Resources/*'

  s.frameworks = 'UIKit'
  s.module_name = 'SNPDialog'
end