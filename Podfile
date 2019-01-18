# Podfile
use_frameworks!
platform :ios, '12.0'


target 'rxconiq' do
    pod 'RxSwift',    '~> 4.0'
    pod 'RxCocoa',    '~> 4.0'
    pod 'RxAlamofire'
    pod 'RxDataSources', '~> 3.0'
end

# RxTest and RxBlocking make the most sense in the context of unit/integration tests
target 'rxconiqTests' do
    pod 'RxBlocking', '~> 4.0'
    pod 'RxTest',     '~> 4.0'
end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
        end
    end
end