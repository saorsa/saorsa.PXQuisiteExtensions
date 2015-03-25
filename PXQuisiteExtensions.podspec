#
# Be sure to run `pod lib lint PXQuisiteExtensions.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "PXQuisiteExtensions"
  s.version          = "0.4"
  s.summary          = "Extension methods for iOS."
  s.description      = <<-DESC
                       I hate giving descriptions. 

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/saorsa/saorsa.PXQuisiteExtensions"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Atanas Dragolov" => "atanas.dragolov@saorsa.bg" }
  s.source           = { :git => "https://github.com/saorsa/saorsa.PXQuisiteExtensions.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/adragolov'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'PXQuisiteExtensions' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit', 'CoreData', 'CoreGraphics', 'QuartzCore'
  # s.dependency 'AFNetworking', '~> 2.3'
end
