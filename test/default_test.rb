require 'test_helper'
include Term::ANSIColor

class DefaultTest < Test::Unit::TestCase

  def setup
  end

  def teardown
  end
  
  def test_underlined_args
    assert_equal underlined_args('bags', 'rags', 'lags'), 
                 underline('bags') + ' ' + underline('rags') + ' ' + underline('lags')
  end
  
  def test_freshen
    bags = {rags: 'lags', hags: 'tags', rags: 'mags'}
    freshen(bags)
    assert_equal bags, {hours: 'none', remaining: 'none', deadline: 'none'}
  end

  def test_new_settings_for
    riggy = {}
    new_settings_for(riggy, {hours: 10, deadline: '2/4/23'})
    assert_equal riggy, {hours: 10, remaining: 10, deadline: parse_and_format('2/4/23')}
  end

  def test_goal_file
    assert_equal goal_file, File.join(ENV['HOME'], '.goal.yml')
  end

  def test_time_capture
    time = "2:34"
    assert_equal time_capture(time, :hours), "2"
    assert_equal time_capture(time, :minutes), "34"
    time = "wags"
  end

  def time_capture_arg_test(time, section=:hours)
    assert_raise ArgumentError do
      time_capture(time, section)
    end
  end

  def test_time_capture_only_takes_hours_or_minutes
    time_capture_arg_test("12:23", :fish)
  end 

  def test_time_capture_only_accepts_time_string
    time_capture_arg_test("2:333")
    time_capture_arg_test("f:23")
  end
end
