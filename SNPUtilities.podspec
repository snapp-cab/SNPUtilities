Pod::Spec.new do |s|
s.name             = 'SNPUtilities'
s.version          = '1.1.2'
s.summary          = 'SNPUtilities is a Swift-based helper library for iOS.'

s.description      = <<-DESC
SNPUtilities is a Swift-based helper library for iOS. It contains for example fileManager related tasks such as clear temp files. It also contains SNPError, a custom error maker which adopts to swift Error class. This SNPError is used in APICalls or as input parameter type.
DESC

s.homepage         = 'https://github.com/snapp-cab/SNPUtilities'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Arash Z. Jahangiri' => 'arashzjahangiri@gmail.com' }
s.source           = { :git => 'https://github.com/snapp-cab/SNPUtilities.git', :tag => s.version.to_s }

s.ios.deployment_target = '9.0'
s.source_files = ['SNPUtilities/Classes/**/*.{swift}', 'SNPUtilities/Classes/**/*.{m}', 'SNPUtilities/Classes/**/*.{h}']
end
