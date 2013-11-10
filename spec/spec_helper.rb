require 'rspec'
require 'pry'
require 'vcr'
require './lib/bgp_tools'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end
