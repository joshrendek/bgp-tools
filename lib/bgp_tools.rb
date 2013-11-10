require 'json'
require 'ipaddr'
require 'rest-client'
require 'nokogiri'
module BgpTools
  USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.101 Safari/537.36"

  ASPrefix = Struct.new(:name, :ip_addr)
  BGPPeer = Struct.new(:as, :name, :ipv6, :rank)
end
require './lib/bgp_tools/as.rb'
