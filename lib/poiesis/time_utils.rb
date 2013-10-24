module TimeUtils
  class << self

    def format_date_string(date)
      Chronic.parse(date).strftime('%B %-d, %Y').gsub(/\d{1,2}(?=,)/) {|d| d.to_i.ordinalize}
    end

    def remaining_time(goal_time, progress_time)
      goal_time, progress_time = time_strings_to_times(goal_time, progress_time) 
      remaining_time = goal_time - progress_time

      if remaining_time <= 0
        "finished"
      else
        hours_minutes(remaining_time)
      end 
    end

    def select_hours_or_minutes(time, section)
      check_for_time_format(time)
      check_for_section_format(section)
      /(?<hours>\d+):(?<minutes>\d+)/.match(time)[:"#{section}"]
    end

    private

      def during_the_same_day
        Time.utc(1960,1,1,0,0,0)
      end

      def time_string_to_time(time_string)
        Chronic.parse(time_string, hours24: true, now: during_the_same_day)
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

      def check_for_section_format(section)
        unless section == :hours || section == :minutes
          raise ArgumentError, "Second arg must be either :hours or :minutes"
        end
      end

      def check_for_time_format(time)
        unless time =~ /(\d+):(\d{2})\z/
          raise ArgumentError, "First arg must be in format 'd+:dd', such as '23:12'"
        end
      end
  end
end
