Gem::Specification.new do |s|
  s.name        = 'bgp-tools'
  s.version     = '0.0.2'
  s.date        = '2013-11-10'
  s.summary     = "A small interface to scrape looking glass information and BGP information."
  s.description = "A small interface to scrape looking glass information and BGP information."
  s.authors     = ["Josh Rendek"]
  s.email       = 'josh@bluescripts.net'
  s.files       = Dir["lib/**"]
  s.homepage    =
    'https://github.com/joshrendek/bgp-tools'
  s.license       = 'MIT'

  spec.add_runtime_dependency 'json'
  spec.add_runtime_dependency 'rest-client'
  spec.add_runtime_dependency 'nokogiri'
  spec.add_runtime_dependency 'rake'
end
