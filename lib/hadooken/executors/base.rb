module Hadooken
  module Executors
    class Base
      attr_reader :topics, :fail_fast

      def initialize(topics, fail_fast)
        @topics = topics
        @consumer_lookup = {}
        @fail_fast = fail_fast
      end

      def shutdown
        true
      end

      private
        def dispatch(message)
          consumer_of(message.topic).perform(message.value, message.topic, fail_fast)
        rescue => e
          Util.capture_error(e, payload: message.value)
        ensure
          release_resources
        end

        def consumer_of(topic)
          @consumer_lookup[topic] ||= topics[topic.to_sym].constantize
        end

        def release_resources
          true
        end

    end
  end
end
