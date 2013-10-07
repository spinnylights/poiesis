module Poiesis
  VERSION = '0.0.1'

  def parse_and_format(date)
    Chronic.parse(date).strftime('%B%e, %Y').gsub(/\d{1,2}(?=,)/) {|d| d.to_i.ordinalize}
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
  end

  def new_settings_for(hash, settings={})
    hash[:hours]    = settings[:hours]
    hash[:deadline] = parse_and_format(settings[:deadline])
  end

  def goal_file
    File.join(ENV['HOME'], '.goal.yml')
  end
end
