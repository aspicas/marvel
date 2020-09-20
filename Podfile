platform :ios, '9.2'

def testing_pods
  pod 'Quick'
  pod 'Nimble'
  pod 'RxTest'
  pod 'RxBlocking'
end

def app_pods
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Moya'
  pod 'Moya/RxSwift'
  pod 'SwiftyBeaver'
  pod 'R.swift'
end

target 'marvel' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for marvel
  app_pods

  target 'marvelTests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

  target 'marvelUITests' do
    # Pods for testing
    testing_pods
  end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.2'
        end
    end
  end

end
