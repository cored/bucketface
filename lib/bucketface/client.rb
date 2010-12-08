module Bucketface
  class Client
    include HTTParty
    format :json
    base_uri "https://api.bitbucket.org/1.0"

    attr_reader :login 

    def initialize(auth={})
      @login = auth[:login]
    end

    def user(login=self.login)
      get_resource("/users/#{login}/").user
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
