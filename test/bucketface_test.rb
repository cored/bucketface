require File.expand_path(File.dirname(__FILE__)) + '/helper'

class BucketfaceTest < Test::Unit::TestCase

  context "when unauthenticated" do 
    should "return user info" do 
      stub_get("/users/cored", "user.json")
      user = Bucketface.user("cored")
      user.login.should == 'cored'
    end
  end
end
