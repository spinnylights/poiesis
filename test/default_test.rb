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
end
