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

    should "return the authenticate client through Bucketface" do
      stub_get('https://cored:2U812@api.bitbucket.org/1.0/users/cored/?', 'full_user.json')
      Bucketface::Client.new(:login => 'cored', :password => '2U812')
      api = Bucketface.current_state
      api.client.user.username.should be_eql('cored')
    end

    should "return followers for an user authenticated user" do 
      stub_get('/users/cored/followers/?', 'followers.json')
      followers = @client.followers
      followers.size.should == 3
    end

    should "open an issue" do
      stub_post('/repositories/cored/test-repo/issues/', 'open_issue.json')
      issue = @client.open_issue({:username => 'cored', :repo => 'test-repo'}, "testing", "testing")
      issue.title.should == "new issue"
    end

    should "delete an issue" do 
      stub_delete('/repositories/cored/test-repo/issues/1/', 'close_issue.txt')
      issue = @client.close_issue({:username => 'cored', :repo => 'test-repo'}, 1)
      issue.should == "Success!"
    end

    should "update an issue"

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

  context "changeset resource" do 
    should "return a list of changeset for a giving repository" do
      stub_get("/repositories/cored/test-repo/changesets/", "changesets.json")
      changesets = Bucketface.changesets(:username => 'cored', :repo => 'test-repo') 
      changesets.size.should == 15
    end

    should "return an specific changeset for a giving repository" do 
      stub_get("/repositories/cored/test-repo/changesets/fa57572a9acf/", "changeset.json")
      changeset = Bucketface.changeset({:username => 'cored', :repo => 'test-repo'}, 'fa57572a9acf')
      changeset.author.should == 'jespern'
    end
  end

  context "events resource" do
    should "return a list of events for a giving user" do
      stub_get("/users/cored/events/", "events.json")
      events = Bucketface.events('cored')
      events.size.should == 5
      events.first.repository.slug.should == 'test-repo'
    end

    should "return a list of events for a giving repository" do
      stub_get("/repositories/cored/test-repo/events/", "repo_events.json")
      events = Bucketface.repo_events(:username => 'cored', :repo => 'test-repo')
      events.size.should == 6
      events.first.repository.slug == 'test-repo'
    end
  end

  context "repository resource" do
    should "return list of followers for a giving repository" do
      stub_get("/repositories/cored/test-repo/followers/", "repo_followers.json")
      repo_followers = Bucketface.repo_followers({:user => "cored", :repo => "test-repo"})
      repo_followers.size.should == 1
    end

    should "return repository info" do 
      stub_get("/repositories/cored/test-repo/", "repo.json")
      repo = Bucketface.repo(:user => "cored", :repo => "test-repo")
      repo.name.should == "test-repo"
    end

    should "list repositories for an user" do
      stub_get("/users/cored/", "repos.json")
      repos = Bucketface.list_repos("cored")
      repos.first.name.should == "test-repo"
    end

    should "list branches in a giving repo" do
      stub_get("/repositories/cored/test-repo/branches/", "branches.json")
      branches = Bucketface.branches(:user => "cored", :repo => "test-repo")
      branches.size.should == 1
      assert branches.include?("default")
    end

    should "list all the tags in a giving repo" do 
      stub_get("/repositories/cored/test-repo/tags/", "tags.json")
      tags = Bucketface.tags(:user => "cored", :repo => "test-repo")
      tags.size.should == 6
      assert tags.include?("0.6.4")
    end
  end
  
  context "issue resource" do
    should "return the list of followers of an issue" do 
      stub_get("/repositories/cored/test-repo/issues/1/followers/", "issue_followers.json")
      issue_followers = Bucketface.issue_followers({:user => "cored", :repo => "test-repo"},"1")
      issue_followers.size.should == 1
    end

    should "return the list of issues for a giving repository" do
      stub_get("/repositories/cored/test-repo/issues/", "issues.json")
      issues = Bucketface.issues({:user => "cored", :repo => "test-repo"})
      issues.size.should == 2
      issues.first.title.should == "Another issue test" 
    end

    should "return an individual issue" do 
      stub_get("/repositories/cored/test-repo/issues/1/", "issue.json")
      issue = Bucketface.issue({:user => "cored", :repo => "test-repo"}, "1")
      issue.title.should == "Test issue"
    end

  end
end
