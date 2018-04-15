Pod::Spec.new do |s|
s.name             = 'SNPUtilities'
s.version          = '0.0.1'
s.summary          = 'SNPUtilities is a Swift-based helper library for iOS.'

s.description      = <<-DESC
SNPUtilities is a Swift-based helper library for iOS. It contains for example fileManager related issues till SNPError maker functions.
DESC

s.homepage         = 'https://github.com/snapp-cab/SNPUtilities'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'arashzjahangiri@gmail.com' => 'arashzjahangiri@gmail.com' }
s.source           = { :git => 'https://github.com/snapp-cab/SNPUtilities.git', :tag => s.version.to_s }

s.ios.deployment_target = '9.0'
s.source_files = 'SNPUtilities/Classes'
#s.dependency 'Alamofire', '~> 4.0'
end
