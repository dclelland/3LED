source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'

use_frameworks!

target '3LED' do
    
    pod 'LIFXClient', '~> 1.0'
    pod 'Reusable', '~> 4.0'
    
    post_install do |installer|
       
        # Write the acknowledgements
        
        require 'fileutils'
        FileUtils.cp('Pods/Target Support Files/Pods-3LED/Pods-3LED-acknowledgements.plist', '3LED/Resources/Settings.bundle/Acknowledgements.plist')
        
    end
    
end
