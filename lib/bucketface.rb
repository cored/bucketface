require "bucketface/version"
require "bucketface/client"

module Bucketface
  class << self

    def new(attributes={})
      Bucketface::Client.new(attributes)
    end
  end
end
