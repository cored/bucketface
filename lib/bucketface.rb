require "bucketface/version"
require "faraday"
require "faraday_middleware"

module Bucketface

  def self.list_privileged_groups
    connection = Faraday.new(:url => 'https://bitbucket.org/api/1.0') do |builder| 
      builder.adapter Faraday.default_adapter
      builder.
    end
  end

end
