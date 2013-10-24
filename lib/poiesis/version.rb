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

  def and_minutes_if_minutes(time)
    minutes = time_capture(time, :minutes)
    if minutes == '00'
      return nil
    else
      return " and #{minutes} minutes "
    end
  end
end
