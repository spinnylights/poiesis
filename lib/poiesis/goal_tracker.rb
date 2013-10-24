class GoalTracker
  require_relative 'guided_object_hash_io'

  attr_accessor :save_file, :hours, :deadline, :remaining
  
  def initialize(args={})
    args = GoalTracker.defaults.merge(args)
    @save_file = args[:save_file]
    @remaining = @hours = args[:hours]
    @deadline = args[:deadline]
  end

  def progress(hours_worked)
    self.remaining = remaining - hours_worked
  end

  def save
    File.open(save_file, "w+") do |file|
      file.write(Psych.dump(goal_info_hash))
    end
  end

  def goal_info_hash
    GuidedObjectHashIO.object_hash_io_with_guide(object: self, 
                                                 hash: {},
                                                 guide: GoalTracker.defaults)
  end

  def load_settings
    loaded_settings_file = File.open(save_file)
    loaded_settings = Psych.load(loaded_settings_file.read)
    GuidedObjectHashIO.object_hash_io_with_guide(object:   self, 
                                                 hash:     loaded_settings, 
                                                 guide:    GoalTracker.defaults,
                                                 into_obj: true)
  end

  class << self
    require 'fileutils'

    attr_writer :defaults_file

    def defaults_file
      @defaults_file || ENV["HOME"] + '/.poiesis_defaults.yml' 
    end

    def method_missing(setting, content=nil)
      if setting[-1,1] == '='
        FileUtils.touch defaults_file
        File.open(defaults_file, 'r+') do |file|
          contents = Psych.load(file.read) || {}
          contents[setting.to_s.chop.to_sym] = content
          file.write(Psych.dump(contents))
        end
      else
        super
      end
    end

    def defaults_hash(defaults={})
      { save_file: defaults[:save_file] || '/tmp/.goal_test.yml', 
        hours:     defaults[:hours],
        deadline:  defaults[:deadline],
        remaining: defaults[:remaining] }
    end

    def defaults
      if File.exists? defaults_file
        defaults = File.open(defaults_file, 'r') do |file| 
          Psych.load(file.read)
        end
        defaults_hash(defaults)
      else
        defaults_hash
      end
    end

    def clean_slate
      GoalTracker.new.save
    end
  end
end
