module Bucketface
  class Repository
    attr_accessor :username, :name

    def initialize(repo)
      case repo
      when String
        repo = repo.split("/")
        @name = repo.pop
        @username = repo.pop
      when Repository
        @username = repo.username
        @name = repo.name
      when Hash
        @name = repo[:repo] ||= repo[:name]
        @username = repo[:username] ||= repo[:user] 
      end
    end

    def user
      @username
    end
  end
end
