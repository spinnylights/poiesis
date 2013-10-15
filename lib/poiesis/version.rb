module Poiesis
  VERSION = '0.0.1'

  def parse_and_format(date)
    Chronic.parse(date).strftime('%B %-d, %Y').gsub(/\d{1,2}(?=,)/) {|d| d.to_i.ordinalize}
  end

  def underlined_args(*args)
    args_string = ''
    args.each do |a|
      args_string += underline(a) + ' '
    end
    args_string.chop
  end

  def freshen(hash)
    hash.clear
    hash[:hours] = "none"
    hash[:deadline] = "none"
    hash[:remaining] = "none"
  end

  def new_settings_for(hash, settings={})
    hash[:hours] = hash[:remaining] = settings[:hours]
    hash[:deadline] = parse_and_format(settings[:deadline])
  end

  def goal_file
    File.join(ENV['HOME'], '.goal.yml')
  end

  def log(goal_time, progress_time)
    goal_time, progress_time = time_strings_to_times(goal_time, progress_time) 
    remaining_time = goal_time - progress_time

    if remaining_time <= 0
      "finished"
    else
      hours_minutes(remaining_time)
    end 
  end

  def time_string_to_time(time_string)
    Chronic.parse(time_string, hours24: true, now: during_the_same_day)
  end

  def during_the_same_day
    Time.utc(1960,1,1,0,0,0)
  end

  def time_strings_to_times(*time_strings)
    times = []
    time_strings.each do |i|
      times << time_string_to_time(i)
    end
    times 
  end
    
  def hours_minutes(remaining_time)
    hours_minutes = {} 
    hours_minutes[:hours], hours_minutes[:minutes] = 
      remaining_time.div(60).divmod(60)
    if hours_minutes[:minutes] == 0
      hours_minutes[:minutes] = '00'
    end
    "#{hours_minutes[:hours]}:#{hours_minutes[:minutes]}"
  end

  def check_for_time_format(time)
    unless time =~ /(\d+):(\d{2})\z/
      raise ArgumentError, "First arg must be in format 'd+:dd', such as '23:12'"
    end
  end

  def check_for_section_format(section)
    unless section == :hours || section == :minutes
      raise ArgumentError, "Second arg must be either :hours or :minutes"
    end
  end

  def time_capture(time, section)
    check_for_time_format(time)
    check_for_section_format(section)
    /(?<hours>\d+):(?<minutes>\d+)/.match(time)[:"#{section}"]
  end

  def and_minutes_if_minutes(time)
    minutes = time_capture(time, :minutes)
    if minutes == '00'
      return nil
    else
      return " and #{minutes} minutes "
    end
  end
end
