Pod::Spec.new do |s|
  s.name = 'CoconutKit'
  s.version = '3.2.3'
  s.license = 'MIT'
  s.summary = 'CoconutKit is a library of high-quality iOS components.'
  s.homepage = 'https://github.com/defagos/CoconutKit'
  s.author = { 'Samuel Défago' => 'defagos@gmail.com' }
  s.source = { :git => 'https://github.com/defagos/CoconutKit.git', :tag => s.version.to_s }
  s.social_media_url = 'http://twitter.com/defagos'
  s.platform = :ios, '7.0'
  
  s.description = <<-DESC
                  CoconutKit is a productivity framework for iOS, crafted with love and focusing on ease of use. It provides a convenient, Cocoa-friendly toolbox to help you efficiently write robust and polished native applications.
                  DESC
                  
  s.frameworks = 'CoreData', 'CoreGraphics', 'CoreText', 'Foundation', 'MessageUI', 'MobileCoreServices', 'QuartzCore', 'QuickLook', 'UIKit', 'WebKit'

  # WARNING: This command is not executed if the pod is installed via :path, see http://guides.cocoapods.org/syntax/podspec.html. In other
  #          words, results are different when the podspec is tested locally, always push to the repository first!
  s.prepare_command = <<-CMD
                      ruby Tools/Scripts/extract_public_headers.rb
                      CMD

  s.requires_arc = true
  s.source_files = 'CoconutKit/Sources/**/*.{h,m}', 'Tools/Scripts/PublicHeaders/*.h'
  s.public_header_files = 'Tools/Scripts/PublicHeaders/*.h'

  # MAZeroingWeakRef external dependency
  zeroing_weak_ref_source_files = 'CoconutKit/Sources/Externals/MAZeroingWeakRef-75695a81/*.{h,m}'

  s.subspec 'zeroing-weak-ref' do |subspec|
    subspec.requires_arc = false
    subspec.source_files = zeroing_weak_ref_source_files
    subspec.public_header_files = nil
    subspec.compiler_flags = '-w'
  end
  
  s.exclude_files = zeroing_weak_ref_source_files

  # Process the publicHeaders.txt file listing public headers to move public headers to a separate directory and create
  # an associated global header
  s.preserve_paths = 'Tools/Scripts/PublicHeaders'

  # Do not use CoconutKit-resources target, use CocoaPods native bundle creation mechanism
  s.resource_bundle = { 'CoconutKit-resources' => ['CoconutKit-resources/{HTML,Images,Nibs}/*', 'CoconutKit-resources/*.lproj'] }
end
