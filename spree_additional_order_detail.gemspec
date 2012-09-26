# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_additional_order_detail'
  s.version     = '1.2.0'
  s.summary     = 'Collect additional order/line_item-level detail before checkout'
  s.description = 'Collect additional order/line_item-level detail before checkout'
  s.required_ruby_version = '>= 1.9.2'

  s.author    = 'Jeff Squires'
  s.email     = 'jeff.squires@gmail.com'
  # s.homepage  = 'http://www.spreecommerce.com'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.2.0'
  s.add_dependency 'wicked'

  s.add_development_dependency 'capybara', '1.0.1'
  s.add_development_dependency 'factory_girl', '~> 2.6.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.9'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'database_cleaner'
end
