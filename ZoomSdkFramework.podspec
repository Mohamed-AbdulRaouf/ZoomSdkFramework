#
# Be sure to run `pod lib lint ZoomSdkFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZoomSdkFramework'
  s.version          = '1.1.1'
  s.summary          = 'easy way to install zoom sdk'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Mohamed-AbdulRaouf/ZoomSdkFramework'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mohamed Abdul-Raouf' => 'mohamed.a.raouf@icloud.com' }
  s.source           = { :git => 'https://github.com/Mohamed-AbdulRaouf/ZoomSdkFramework.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Mohamed97789445'
  s.swift_version = '5.0'
  s.ios.deployment_target = '9.0'

  s.source_files = 'ZoomSdkFramework/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZoomSdkFramework' => ['ZoomSdkFramework/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
