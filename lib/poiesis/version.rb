module Poiesis
  VERSION = '0.0.1'

  def underlined_args(*args)
    args_string = ''
    args.each do |a|
      args_string += underline(a) + ' '
    end
    args_string.chop
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
