require 'test_helper'
include Term::ANSIColor

class DefaultTest < Test::Unit::TestCase

  def setup
  end

  def teardown
  end

  def test_parse_and_format
    assert_equal parse_and_format('4/7/2030'), 'April 7th, 2030' 
  end
  
  def test_underlined_args
    assert_equal underlined_args('bags', 'rags', 'lags'), 
                 underline('bags') + ' ' + underline('rags') + ' ' + underline('lags')
  end
  
  def test_freshen
    bags = {rags: 'lags', hags: 'tags', rags: 'mags'}
    freshen(bags)
    assert_equal bags, {hours: 'none', deadline: 'none'}
  end

  def test_new_settings_for
    riggy = {}
    new_settings_for(riggy, { hours: 10, deadline: '2/4/23' })
    assert_equal riggy, {hours: 10, deadline: parse_and_format('2/4/23')}
  end

  def test_goal_file
    assert_equal goal_file, File.join(ENV['HOME'], '.goal.yml')
  end
end
