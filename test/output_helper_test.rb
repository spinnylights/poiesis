require 'test_helper'
include OutputHelper
include Term::ANSIColor

class OutputHelperTest < Test::Unit::TestCase

  def test_underlined_args
    assert_equal underlined_args('bags', 'rags', 'lags'), 
                 underline('bags') + ' ' + underline('rags') + ' ' + underline('lags')
  end

  def test_and_minutes_if_minutes_returns_nil_if_no_minutes
    assert_equal nil, and_minutes_if_minutes('23:00')
  end
end
