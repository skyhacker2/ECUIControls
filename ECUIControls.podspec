#
# Be sure to run `pod lib lint ECUIControls.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ECUIControls"
  s.version          = "0.1.4"
  s.summary          = "ECUIControls provides a group of custom control"
  s.description      = <<-DESC
                        #ECUIControls provides a group of custom control.
                       DESC
  s.homepage         = "https://github.com/skyhacker2/ECUIControls"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Eleven Chen" => "skyhacker@126.com" }
  s.source           = { :git => "https://github.com/skyhacker2/ECUIControls.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ECUIControls' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
    s.dependency 'ECExtension'
end
