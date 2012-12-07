require 'spec_helper'

describe Bucketface do 

  context ".respond_to?" do 
    subject { Bucketface.respond_to?(:new, true) }
    it { should be_true }
  end

  context ".new" do 
    subject { Bucketface.new } 
    it { should be_a Bucketface::Client }
  end
end
