module Elbas
  module Aws
    # Provide EC2 client and resource information
    module EC2
      extend ActiveSupport::Concern

      include Capistrano::DSL

      def ec2_resource
        @_ec2_resource ||= ::Aws::EC2::Resource.new(client: ec2_client)
      end

      def reset_ec2_objects
        @_ec2_resource = nil
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

      def ec2_client
        ::Aws::EC2::Client.new(credentials)
      end
    end
  end
end
