# Sources configuration
source 'https://github.com/CocoaPods/Specs.git'

workspace 'Components'

platform :ios, '11.0'
use_frameworks!

inhibit_all_warnings!

target 'Component' do

  pod 'SwiftLint', '~> 0.25.0'


  target 'ComponentUITests' do
     inherit! :search_paths
  end

  target 'ComponentTests' do
    inherit! :search_paths

    pod 'Quick', '~> 1.2.0'
    pod 'Nimble', '~> 7.0.3'
    # pod 'iOSSnapshotTestCase', '~> 2.1.6'
    # pod 'iOSSnapshotTestCase', path: '../ExternalForks/ios-snapshot-test-case/'
    # until we don't have an official version from uber we can use ours.
    pod 'iOSSnapshotTestCase', git: 'https://github.com/nunogoncalves/ios-snapshot-test-case.git', branch: 'working-flexible-names'
  end
end
