# Sources configuration
source 'https://cdn.cocoapods.org/'

workspace 'Components'

platform :ios, '13.0'
supports_swift_versions '>= 5.0'

install! 'cocoapods',
    :generate_multiple_pod_projects => true,
    :incremental_installation => true

use_frameworks!
inhibit_all_warnings!

target 'Component' do

  pod 'SwiftLint'

  target 'ComponentUITests' do
     inherit! :search_paths
  end

  target 'ComponentTests' do
    inherit! :search_paths

    pod 'Quick', '~> 2.1'
    pod 'Nimble', '~> 8.0'
    pod 'iOSSnapshotTestCase', '~> 6.2.0'
  end
end
