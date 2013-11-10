require 'spec_helper'

describe BgpTools::AS do
  subject do
    VCR.use_cassette('as_174') do
      BgpTools::AS.new(174)
    end
  end

  its(:as_path_length){ should == 3.637 }
end
