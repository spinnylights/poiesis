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
end
