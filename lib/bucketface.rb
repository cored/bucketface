require 'forwardable'

require 'httparty'
require 'hashie'
Hash.send :include, Hashie::HashExtensions

libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'bucketface/repository'
require 'bucketface/client'

module Bucketface
  extend SingleForwardable

  class BucketfaceError < StandardError
    attr_reader :data

    def initialize(data)
      @data = data
      super
    end
  end

  def self.client; Client.new end

  # Users
  def_delegators :client, :user, :followers 

  # Repositories
  def_delegators :client, :repo_followers, :repo, :list_repos, :branches, :tags

  # Issues
  def_delegators :client, :issue_followers, :issues, :issue

  # Changesets
  def_delegators :client, :changesets, :changeset

  # Events
  def_delegators :client, :events, :repo_events
end
