# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'FoodNearMe' do
  # Uncomment this line if you're using Swift or would like to use dynamic frameworks
   use_frameworks!

  # Pods for FoodNearMe
  pod 'Alamofire'

  target 'FoodNearMeTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'OCMock'
  end

post_install do |installer|
    # Your list of targets here.

    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end

end
