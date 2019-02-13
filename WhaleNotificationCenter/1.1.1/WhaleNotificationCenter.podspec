#
# Be sure to run `pod lib lint SPModel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#  pod spec validate:
#     -gem install fourflusher
#     -pod repo remove WhaleNotificationCenter
#     -pod repo add WhaleNotificationCenter https://github.com/rbozdag/WhaleNotificationCenter.git
#     -pod repo push WhaleNotificationCenter WhaleNotificationCenter.podspec --allow-warnings

Pod::Spec.new do |s|
  s.name             = 'WhaleNotificationCenter'
  s.version          = '1.1.1'
  s.summary          = 'Swift NSNotificationCenter Fix Library'

  s.description      = <<-DESC
Swift NSNotificationCenter Fix Library
                       DESC

  s.homepage         = 'https://github.com/rbozdag'
  s.license          = { :type => "BSD", :file => "LICENSE.md" }
  s.author           = { 'rbozdag' => 'bozdag.rahmi@gmail.com' }
  s.source           = { :git => "https://github.com/rbozdag/WhaleNotificationCenter.git", :tag => "#{s.version}" }

  s.swift_version = '4.2'
  s.source_files = 'Source/WhaleNotificationCenter/**/*.{swift,h,m}'

  s.ios.deployment_target = '9.0'
  s.platform     = :ios, "9.0"
end
