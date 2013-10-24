require 'test_helper'

class TimeUtilsTest < Test::Unit::TestCase

  def test_format_date_string
    assert_equal TimeUtils.format_date_string('4/7/2030'), 'April 7th, 2030' 
  end

  def test_remaining_time_under_ten_hours
    assert_equal TimeUtils.remaining_time("8:29", "3:42"), "4:47"
  end 

  def test_remaining_time_over_ten_hours
    assert_equal TimeUtils.remaining_time("20:00", "1:02"), "18:58"
  end

  def test_remaining_time_finished
    assert_equal TimeUtils.remaining_time("8:29", "9:42"), "finished"
  end

  def time
    "2:34"
  end

  def test_select_hours_or_minutes_hours
    assert_equal TimeUtils.select_hours_or_minutes(time, :hours), "2"
  end

  def test_select_hours_or_minutes_minutes
    assert_equal TimeUtils.select_hours_or_minutes(time, :minutes), "34"
  end

  def select_hours_or_minutes_arg_test(time, section=:hours)
    assert_raise ArgumentError do
      TimeUtils.select_hours_or_minutes(time, section)
    end
  end

  def test_select_hours_or_minutes_only_takes_hours_or_minutes
    select_hours_or_minutes_arg_test("12:23", :fish)
  end 

  def test_select_hours_or_minutes_wont_accept_hundreds_of_minutes
    select_hours_or_minutes_arg_test("2:333")
  end

  def test_select_hours_or_minutes_wont_accept_letter_in_time_string
    select_hours_or_minutes_arg_test("f:23")
  end
end
