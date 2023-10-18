# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MetaMeds' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

pod 'IQKeyboardManagerSwift'
 pod 'SDWebImage'
 pod 'FSPagerView'
 pod 'SideMenu'
 pod 'GoogleMaps'
 pod 'GooglePlaces'
 pod 'DropDown'
 pod 'BSImagePicker'
 pod 'Cosmos', '~> 23.0'
  pod 'Firebase/Analytics'
  pod 'Firebase/Messaging'
  # Pods for MetaMeds

end

post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
          xcconfig_path = config.base_configuration_reference.real_path
          xcconfig = File.read(xcconfig_path)
          xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
          File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
          end
      end
  end
