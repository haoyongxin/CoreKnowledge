 
platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

  pod 'MJRefresh', '~> 2.4.10'
  pod 'AFNetworking', '~> 3.2.0'
  pod 'pop', '~> 1.0.8'
#  pod 'FDFullscreenPopGesture', '~> 1.1'
  pod 'SDWebImage', '~> 3.7.3'
  pod 'FMDB', '~> 2.5'
  pod 'Reachability', '~> 3.2'

target 'CoreKnowledge' do

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end

