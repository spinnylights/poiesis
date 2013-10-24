require 'aruba/cucumber'
require 'fileutils'
require_relative '../../lib/poiesis/goal_tracker.rb'

include FileUtils
include Poiesis

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
LIB_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'..','..','lib')

def make_home_fake
  # By Dave Copeland, from http://youtu.be/5zBK-rIje2c?t=14m22s
  @real_home = ENV['HOME']
  fake_home = File.join('/tmp', 'fakehome')
  rm_rf fake_home if File.exists? fake_home
  mkdir_p fake_home
  ENV['HOME'] = fake_home
end

def make_home_real
  ENV['HOME'] = @real_home
end

Before do
  # Using "announce" causes massive warnings on 1.9.2
  @puts = true
  @original_rubylib = ENV['RUBYLIB']
  ENV['RUBYLIB'] = LIB_DIR + File::PATH_SEPARATOR + ENV['RUBYLIB'].to_s
  make_home_fake
  rm_rf GoalTracker.new.save_file
end

After do
  ENV['RUBYLIB'] = @original_rubylib
  make_home_real
end
