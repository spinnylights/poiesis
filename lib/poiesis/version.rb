module Poiesis
  VERSION = '0.0.1'

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
