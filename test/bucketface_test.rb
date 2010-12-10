require File.expand_path(File.dirname(__FILE__)) + '/helper'

class BucketfaceTest < Test::Unit::TestCase
  context "when authenticated" do 
    setup do 
      @client = Bucketface::Client.new(:login => 'cored', :token => '2U812')
    end

    should "authenticate via basic auth" do 
      stub_get('https://cored:2U812@api.bitbucket.org/1.0/users/cored/?', 'full_user.json')
      client = Bucketface::Client.new(:login => 'cored', :password => '2U812')
      user = client.user
      user.is_private?.should == false
    end

    should "return followers for an user authenticated user" do 
      stub_get('/users/cored/followers', 'followers.json')
      followers = @client.followers
      followers.size.should == 3
    end

    should "open an issue" 
  end

  context "user resource" do 
    should "return user info" do 
      stub_get("/users/cored/", "user.json")
      user = Bucketface.user("cored")
      user.username.should == 'cored'
    end

    should "return followers for a user" do
      stub_get("/users/cored/followers/", "followers.json")
      followers = Bucketface.followers("cored")
      followers.size.should == 3 
    end
  end

  context "repository resource" do
    should "return list of followers for a giving repository" do
      stub_get("/repositories/cored/test-repo/followers/", "repo_followers.json")
      repo_followers = Bucketface.repo_followers({:user => "cored", :repository => "test-repo"})
      repo_followers.size.should == 1
    end

    should "return repository info" do 
      stub_get("/repositories/cored/test-repo/", "repo.json")
      repo = Bucketface.repo(:user => "cored", :repository => "test-repo")
      repo.name.should == "test-repo"
    end

    should "list repositories for an user" do
      stub_get("/users/cored/", "repos.json")
      repos = Bucketface.list_repos("cored")
      repos.first.name.should == "test-repo"
    end

    should "list branches in a giving repo" do
      stub_get("/repositories/cored/test-repo/branches/", "branches.json")
      branches = Bucketface.branches(:user => "cored", :repository => "test-repo")
      branches.size.should == 1
      assert branches.include?("default")
    end

    should "list all the tags in a giving repo" do 
      stub_get("/repositories/cored/test-repo/tags/", "tags.json")
      tags = Bucketface.tags(:user => "cored", :repository => "test-repo")
      tags.size.should == 6
      assert tags.include?("0.6.4")
    end
  end
  
  context "issue resource" do
    should "return the list of followers of an issue" do 
      stub_get("/repositories/cored/test-repo/issues/1/followers/", "issue_followers.json")
      issue_followers = Bucketface.issue_followers({:user => "cored", :repository => "test-repo", :issue_id => "1"})
      issue_followers.size.should == 1
    end

    should "return the list of issues for a giving repository" do
      stub_get("/repositories/cored/test-repo/issues/", "issues.json")
      issues = Bucketface.issues({:user => "cored", :repository => "test-repo"})
      issues.size.should == 2
      issues.first.title.should == "Another issue test" 
    end

    should "return an individual issue" do 
      stub_get("/repositories/cored/test-repo/issues/1/", "issue.json")
      issue = Bucketface.issue(:user => "cored", :repository => "test-repo", :issue_id => "1")
      issue.title.should == "Test issue"
    end

  end
end
