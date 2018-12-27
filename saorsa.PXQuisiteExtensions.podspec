#
# Be sure to run `pod lib lint saorsa.PXQuisiteExtensions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'saorsa.PXQuisiteExtensions'
  s.version          = '0.8'
  s.summary          = 'A collection of useful extension methods for iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
I have decided to put a collection of extension methods that I use often
while developing iOS projects. Most of these are related to the Foundation classes such
as NSString, NSDate and NSDateFormatter. Over the course of usage I have added more
for the CoreGraphics, CoreData and UIKit classes.
                       DESC

  s.homepage         = 'https://github.com/saorsa/saorsa.PXQuisiteExtensions'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Saorsa' => 'adragolov@gmail.com' }
  s.source           = { :git => 'https://github.com/saorsa/saorsa.PXQuisiteExtensions.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'saorsa.PXQuisiteExtensions/Classes/**/*'
  
  # s.resource_bundles = {
  #   'saorsa.PXQuisiteExtensions' => ['saorsa.PXQuisiteExtensions/Assets/*.png']
  # }

  s.public_header_files = 'saorsa.PXQuisiteExtensions/**/*.h'
  s.frameworks = 'Foundation', 'CoreData', 'UIKit'
  s.dependency 'LINQ4Obj-C'
end
