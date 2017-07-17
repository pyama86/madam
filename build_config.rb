def gem_config(conf)
  #conf.gembox 'default'

  # be sure to include this gem (the cli app)
  conf.gem File.expand_path(File.dirname(__FILE__))
end

MRuby::Build.new do |conf|
  toolchain :gcc

  conf.enable_bintest
  conf.enable_debug
  conf.enable_test

  gem_config(conf)
end

MRuby::Build.new('x86_64-pc-linux-gnu') do |conf|
  toolchain :gcc

  gem_config(conf)
end

#MRuby::Build.new do |conf|
#  toolchain :gcc
#  conf.gembox 'default'
#  conf.gem File.expand_path(File.dirname(__FILE__))
#  conf.enable_test
#  conf.cc.flags << "-O0 -g3"
#end
