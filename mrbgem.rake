MRuby::Gem::Specification.new('madam') do |spec|
  spec.license = 'MIT'
  spec.author  = 'MRuby Developer'
  spec.summary = 'madam'
  spec.bins    = ['madam']

  spec.add_dependency 'mruby-print', :core => 'mruby-print'
  spec.add_dependency 'mruby-mtest', :mgem => 'mruby-mtest'
  spec.add_dependency 'mruby-process'
  spec.add_dependency 'mruby-ipvs'
  spec.add_dependency 'mruby-json'
end
