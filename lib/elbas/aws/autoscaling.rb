module Elbas
  module Aws
    # Provide AutoScaling client, resource, and group information
    module AutoScaling
      extend ActiveSupport::Concern
      include Capistrano::DSL

      def autoscaling_client
        @_autoscaling_client ||= ::Aws::AutoScaling::Client.new(credentials)
      end

      def autoscaling_resource
        @_autoscaling_resource ||= ::Aws::AutoScaling::Resource.new(client: autoscaling_client)
      end

      def autoscaling_group
        @_autoscaling_group ||= autoscaling_resource.group(autoscaling_group_name)
      end

      def autoscaling_group_name
        fetch(:aws_autoscale_group)
      end

      def reset_autoscaling_objects
        @_autoscaling_client = nil
        @_autoscaling_resource = nil
        @_autoscaling_group = nil
      end

      private

      def credentials
        _credentials = {
          access_key_id:     fetch(:aws_access_key_id,     ENV['AWS_ACCESS_KEY_ID']),
          secret_access_key: fetch(:aws_secret_access_key, ENV['AWS_SECRET_ACCESS_KEY']),
          region:            fetch(:aws_region,            ENV['AWS_REGION'])
        }
        _credentials.merge! region: fetch(:region) if fetch(:region)
        _credentials
      end
    end
  end
end
