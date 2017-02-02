module Utils
  class Facebook
    class << self
      def convert_timestamp_to_time(timestamp)
        Time.zone.at(timestamp.to_i/1000)
      end
    end
  end
end
