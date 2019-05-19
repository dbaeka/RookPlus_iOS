# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RookPlus' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RookPlus
  pod 'Firebase/Core'
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'Kingfisher', '~> 5.0'
  pod 'FirebaseMessaging'
  pod 'IQKeyboardManagerSwift'
  pod 'FacebookCore'
  pod 'FBSDKLoginKit'
  pod 'TwitterKit'
  pod 'LinkedinSwift', '~> 1.7'
  pod 'VSAlert'
  pod 'BlueCryptor'
  pod 'BigInt'
  pod 'Fabric'
  pod 'Crashlytics'
 end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.2'
    end
  end
end
