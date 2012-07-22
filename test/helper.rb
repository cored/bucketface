require 'test/unit'
require 'pathname'

require 'minitest/autorun'
require 'matchy'
require 'mocha'
require 'fakeweb'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'bucketface'

FakeWeb.allow_net_connect = false

# Code from mini_shoulda https://github.com/metaskills/mini_shoulda
class MiniTest::Spec < MiniTest::Unit::TestCase
  class << self
    alias :setup    :before
    alias :teardown :after
    alias :should   :it
    alias :context  :describe
  end
  
  def self.should_eventually(desc)
    it("should eventually #{desc}") { skip("Should eventually #{desc}") }
  end
end

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end

def bitbucket_url(url)
  url =~ /^https/ ? url : "https://api.bitbucket.org/1.0#{url}"
end

def stub_request(method, url, filename, status=nil)
  options = {:body => ""}
  options.merge!({:body => fixture_file(filename)}) if filename
  options.merge!({:body => status.last}) if status
  options.merge!({:status => status}) if status

  FakeWeb.register_uri(method, bitbucket_url(url), options) 
end

def stub_get(*args); stub_request(:get, *args) end
def stub_post(*args); stub_request(:post, *args) end
def stub_delete(*args); stub_request(:delete, *args) end
