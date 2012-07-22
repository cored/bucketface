require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  Dir[File.dirname(__FILE__) + "/test/**/*_test.rb"].each do |path|
    require_relative path
  end
  MiniTest::Unit.autorun
end
