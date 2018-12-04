#
# Be sure to run `pod lib lint ToastCollectionView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'ToastCollectionView'
  s.version          = '0.2.0'
  s.swift_version    = '4.2'
  s.summary          = 'A UICollectionView cell that animate Toast Views while scrolling.'
  s.description      = 'A UICollectionView cell that shows and animates a toast when appearing on screen.'

  s.homepage         = 'https://github.com/scaraux/ToastCollectionViewCell'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Oscar Gotting' => 'https://twitter.com/scaraux' }
  s.source           = { :git => 'https://github.com/scaraux/ToastCollectionViewCell.git', :tag => s.version.to_s }


  s.ios.deployment_target = '9.0'

  s.source_files = 'ToastCollectionView/Classes/**/*'
  
end
