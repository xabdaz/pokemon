platform :ios, '12.4'
workspace 'production.xcworkspace'

def module_domain
  pod 'ModuleDomain', :path => 'Module/ModuleDomain'
end

def module_core
  pod 'ModuleCore', :path => 'Module/ModuleCore'
end
def module_user
  pod 'ModuleUser', :path => 'Module/ModuleUser'
end

target 'production' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # Add the Firebase pod for Google Analytics
  pod 'FirebaseAnalytics'

  # For Analytics without IDFA collection capability, use this pod instead
  # pod ‘Firebase/AnalyticsWithoutAdIdSupport’

  # Add the pods for any other Firebase products you want to use in your app
  # For example, to use Firebase Authentication and Cloud Firestore
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'

  pod 'GoogleSignIn'
  
  pod 'PokemonAPI'

  pod 'RxSwift', '~> 5', :inhibit_warnings => true
  pod 'RxCocoa', '~> 5', :inhibit_warnings => true
  pod 'RxDataSources', '~> 4', :inhibit_warnings => true
  module_domain
  module_core

  pod 'Swinject'
  pod 'SwinjectAutoregistration'
  
  pod 'Kingfisher', '~> 7.0'
end

target 'ModuleDomain_Example' do
  use_frameworks!
  project 'Module/ModuleDomain/Example/ModuleDomain.xcodeproj'
  module_domain
  pod 'PokemonAPI'
end

target 'ModuleCore_Example' do
  use_frameworks!
  project 'Module/ModuleCore/Example/ModuleCore.xcodeproj'
  module_core
  pod 'Swinject'
  pod 'SwinjectAutoregistration'
  
end
target 'ModuleUser_Example' do
  use_frameworks!
  project 'Module/ModuleUser/Example/ModuleUser.xcodeproj'
  module_user
  pod 'Swinject'
  pod 'SwinjectAutoregistration'
  
end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.4'
            end
        end
    end
end
