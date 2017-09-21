#
# Be sure to run `pod lib lint ReSwiftDataSource.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ReSwiftDataSource'
  s.version          = '1.2.0'
  s.summary          = 'CollectionView, TableView DataSource using ReSwift states'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "ReSwiftDataSource uses ReSwift state as datasource
    for the collectionView"

  s.homepage         = 'https://github.com/sisomollov/ReSwiftDataSource'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SiSo Mollov' => 'mollov@me.com' }
  s.source           = { :git => 'https://github.com/sisomollov/ReSwiftDataSource.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'ReSwiftDataSource/Source/**/*'

  # s.resource_bundles = {
  #   'ReSwiftDataSource' => ['ReSwiftDataSource/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.ios.framework = 'UIKit'
  s.dependency 'ReSwift'
  s.dependency 'Changeset'
end
