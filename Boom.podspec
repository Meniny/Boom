Pod::Spec.new do |s|
  s.name        = 'Boom'
  s.module_name = 'Boom'
  s.version     = '1.0.1'
  s.summary     = 'UITableView and UICollectionView manager with efficient, declarative and type-safe approach.'

  s.homepage    = 'https://github.com/Meniny/Boom'
  s.license     = { type: 'MIT', file: 'LICENSE.md' }
  s.authors     = { 'Elias Abel' => 'admin@meniny.cn' }
  s.social_media_url = 'https://meniny.cn/'

  s.ios.deployment_target     = '9.0'

  s.source              = { git: 'https://github.com/Meniny/Boom.git', tag: s.version.to_s }
  s.source_files        = 'Boom/**/*.swift'

  s.requires_arc        = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.1' }
  s.swift_version       = '4.1'
end
