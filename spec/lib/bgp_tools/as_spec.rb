require 'spec_helper'

describe BgpTools::AS do
  subject do
    VCR.use_cassette('as_174') do
      BgpTools::AS.new(174)
    end
  end

  its(:as_path_length){ should == 3.637 }
  its(:country_of_origin) { should == "United States" }

  its(:ips_originated) { should == 27982592 }

  it "should include Cogent as a peer" do
    needle = IPAddr.new('66.28.252.0')
    haystack = subject.prefix_list.select{|x| x.ip_addr.include? needle }
    haystack.count.should == 2
    haystack.first.name.should == "Cogent Communications"
  end

  it "should have Level3 as a BGP Peer" do
    needle = "Level 3 Communications, Inc."
    haystack = subject.bgp_peer_list.select {|x| x.name == needle }
    haystack.count.should == 1
    haystack.first.name == needle
  end

  it "should contain 66.28.252.1" do
    subject.contains?("66.28.252.1").should == true
  end

end
