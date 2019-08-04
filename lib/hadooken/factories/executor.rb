module Hadooken
  module Factories
    class Executor
      class << self
        def create(configs)
          if configs[:type] == :single_thread
            Executors::SingleThread.new(configs[:topics], configs[:fail_fast])
          else
            Executors::MultiThread.new(configs[:topics], configs[:threads], configs[:fail_fast])
          end
        end
      end
    end
  end
end
