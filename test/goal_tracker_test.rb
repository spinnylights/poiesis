require 'test_helper'
require 'fileutils'

class GoalTrackerTest < Test::Unit::TestCase

  SAVE_PATH     = '/tmp/.goal_test.yml'
  DEFAULTS_PATH = '/tmp/.goal_test_defaults.yml'

  def setup
    FileUtils.rm_f [SAVE_PATH, DEFAULTS_PATH]
    GoalTracker.defaults_file = DEFAULTS_PATH
    @goal = GoalTracker.new(save_file: SAVE_PATH,
                            hours: 20,
                            deadline: '2/14/30')
    @goal.remaining = @goal.hours
  end

  def test_progress
    @goal.progress(10)
    assert_equal 10, @goal.remaining
  end

  def test_save
    @goal.save
    save_file = File.open(SAVE_PATH) { |file| Psych.load(file) }
    assert_equal @goal.goal_info_hash, save_file
  end

  def test_load_settings
    initial_goal = GoalTracker.new(save_file: SAVE_PATH,
                                    hours: 15)
    loaded_goal = GoalTracker.new(save_file: SAVE_PATH)
    initial_goal.save
    loaded_goal.load_settings
    assert_equal initial_goal.hours, loaded_goal.hours
  end

  def test_clean_slate
    @goal.save
    GoalTracker.clean_slate
    fresh_goal = GoalTracker.new
    assert_equal GoalTracker.defaults, fresh_goal.goal_info_hash  
  end

  def test_changing_defaults
    new_save_file = GoalTracker.save_file = '/tmp/.changed_goal_test.yml'
    new_defaults = GoalTracker.new
    assert_equal new_save_file, new_defaults.save_file
  end

  def test_method_missing_works_as_normal_without_=
    assert_raise NoMethodError do
      GoalTracker.fake_method
    end
  end
end
