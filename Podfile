platform :ios, '10.0'

target 'RookPlus' do
    use_frameworks!
    # Pods for RookPlus
    pod 'Fabric'
    pod 'Crashlytics'
    pod 'Firebase/Core'
    pod 'Firebase/Messaging'
    pod 'Firebase/RemoteConfig'
    pod 'Mixpanel-swift'
    pod 'Alamofire'
    pod 'Kingfisher'
    pod 'TwitterKit'
    pod 'SwiftyJSON'
    pod 'BlueCryptor'
    pod 'IQKeyboardManager'
    pod 'BigInt', '~> 3.1'
    pod 'LinkedinSwift'
    pod 'FBSDKLoginKit'
    pod 'VSAlert'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.2'
        end
    end
end
