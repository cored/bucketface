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
    end

    def user(login=self.login)
      get_resource("/users/#{login}/").user
    end

    def followers(login=self.login)
      get("/users/#{login}/followers/").followers
    end

    def repo_followers(args = {})
      get("/repositories/#{args[:user]}/#{args[:repository]}/followers/").followers
    end

    def issue_followers(args = {})
      get("/repositories/#{args[:user]}/#{args[:repository]}/issues/#{args[:issue_id]}/followers/").followers
    end

    def issues(args = {})
      get("/repositories/#{args[:user]}/#{args[:repository]}/issues/").issues
    end

    def issue(args = {})
      get("/repositories/#{args[:user]}/#{args[:repository]}/issues/#{args[:issue_id]}/")
    end

    def repo(args = {})
      get("/repositories/#{args[:user]}/#{args[:repository]}/")
    end

    def list_repos(login=self.login)
      get("/users/#{login}/").repositories
    end

    def branches(args = {})
      get("/repositories/#{args[:user]}/#{args[:repository]}/branches/")
    end

    def tags(args = {})
      get("/repositories/#{args[:user]}/#{args[:repository]}/tags/")
    end

    private
    def get(path, options = {})
      Hashie::Mash.new(self.class.get(path, options))
    end

    def get_resource(path, options ={})
      get(path, {:query => options})
    end
  end
end
