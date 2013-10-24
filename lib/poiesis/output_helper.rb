module OutputHelper

  def underlined_args(*args)
    args_string = ''
    args.each do |a|
      args_string += underline(a) + ' '
    end
    args_string.chop
  end

  def and_minutes_if_minutes(time)
    minutes = TimeUtils.select_hours_or_minutes(time, :minutes)
    if minutes == '00'
      return nil
    else
      return " and #{minutes} minutes "
    end
  end
end
