describe Bucketface, '.list_privileged_groups' do 
  subject { Bucketface.list_privileged_groups }

  context "return list of privileged groups" do 
    it { should == "" }
  end

end
