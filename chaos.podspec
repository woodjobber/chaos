#
# Be sure to run `pod lib lint chaos.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'chaos'
  s.version          = '0.0.1'
  s.summary          = '模糊匹配'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
模糊搜索，模糊匹配，
                       DESC

  s.homepage         = 'https://github.com/woodjobber/chaos'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'woodjobber' => 'woodjobber@outlook.com' }
  s.source           = { :git => 'https://github.com/woodjobber/chaos.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'chaos/Classes/**/*'
  
  s.requires_arc = true
  
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES'}
  
  # Swift版本
   s.swift_versions = '5.0'
   
  # s.resource_bundles = {
  #   'chaos' => ['chaos/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
