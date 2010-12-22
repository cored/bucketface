module Bucketface
  class Client
    include HTTParty 
    format :json
    base_uri "https://api.bitbucket.org/1.0"

    attr_reader :login 

    def initialize(auth={})
      if auth[:password].nil?
        @login = auth[:login]
        @token = auth[:token]
        self.class.basic_auth(nil, nil)
      else
        @login = auth[:login]
        self.class.basic_auth(@login, auth[:password])
      end
      @@api = self
    end

    def self.api
      @@api
    end

    def user(login=self.login)
      get("/users/#{login}/").user
    end

    def followers(login=self.login)
      get("/users/#{login}/followers/").followers
    end

    def repo_followers(repo)
      repo = Repository.new(repo)
      get("/repositories/#{repo.user}/#{repo}/followers/").followers
    end

    def issue_followers(repo, id)
      repo = Repository.new(repo)
      get("/repositories/#{repo.user}/#{repo}/issues/#{id}/followers/").followers
    end

    def issues(repo)
      repo = Repository.new(repo)
      get("/repositories/#{repo.user}/#{repo}/issues/").issues
    end

    def issue(repo, id)
      repo = Repository.new(repo)
      get("/repositories/#{repo.user}/#{repo}/issues/#{id}/")
    end

    def repo(repo)
      repo = Repository.new(repo)
      get("/repositories/#{repo.user}/#{repo}/")
    end

    def list_repos(login=self.login)
      get("/users/#{login}/").repositories
    end

    def branches(repo)
      repo = Repository.new(repo)
      get("/repositories/#{repo.user}/#{repo}/branches/")
    end

    def tags(repo)
      repo = Repository.new(repo)
      get("/repositories/#{repo.user}/#{repo}/tags/")
    end

    def open_issue(repo, title, body)
      rep = Repository.new(repo)
      post("/repositories/#{rep.user}/#{rep}/issues/", :body => {:title => title, :content => body, :status => 'new'})
    end

    def delete_issue(repo, id)
      repo = Repository.new(repo)
      delete("/repositories/#{repo.user}/#{repo}/issues/#{id}/")
    end

    def changesets(repo)
      repo = Repository.new(repo)
      get_resource("/repositories/#{repo.user}/#{repo}/changesets/").changesets
    end

    def changeset(repo, changeset)
      repo = Repository.new(repo)
      get("/repositories/#{repo.user}/#{repo}/changesets/#{changeset}/")
    end

    def events(login=self.login)
      get("/users/#{login}/events/").events
    end
    
    def repo_events(repo)
      repo = Repository.new(repo)
      get("/repositories/#{repo.user}/#{repo}/events/").events
    end

    private
    def get(path, options = {})
      Hashie::Mash.new(self.class.get(path, options))
    end

    def post(path, options = {})
      Hashie::Mash.new(self.class.post(path, options))
    end

    def delete(path, options = {})
      self.class.delete(path, options)
    end

    def get_resource(path, options ={})
      get(path, {:query => options})
    end

    def post_resource(path, options = {})
      post(path, options)
    end

    def self.delete(*args); handle_response super end

    def self.handle_response(response)
      case response.code
      when 204        then return "Success!"
      else
        response
      end
    end
  end
end
