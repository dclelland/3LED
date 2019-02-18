source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'

use_frameworks!

# Fix Development Pods/Remove Derived Data issues: https://github.com/CocoaPods/CocoaPods/pull/8105#issuecomment-434767099

install! 'cocoapods', disable_input_output_paths: true

target '3LED' do
    
    pod 'LIFXClient', path: '../LIFXClient'
    
     post_install do |installer|
       
         # Write the acknowledgements
        
         require 'fileutils'
         FileUtils.cp('Pods/Target Support Files/Pods-3LED/Pods-3LED-acknowledgements.plist', '3LED/Resources/Settings.bundle/Acknowledgements.plist')
        
     end
    
end
