module Elbas
  module AWS
    class Instance < Base
      STATE_RUNNING = 16.freeze

      attr_reader :aws_counterpart, :id, :state

      def initialize(id, private_ip, state)
        @id = id
        @private_ip = private_ip
        @state = state
        @aws_counterpart = aws_namespace::Instance.new id, client: aws_client
      end

      def hostname
        @private_ip
      end

      def running?
        state == STATE_RUNNING
      end

      private
        def aws_namespace
          ::Aws::EC2
        end
    end
  end
end
