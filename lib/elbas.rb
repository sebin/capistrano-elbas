require 'aws-sdk'
require 'capistrano/all'
require 'active_support/concern'

require 'elbas/version'
require 'elbas/retryable'
require 'elbas/taggable'
require 'elbas/logger'
require 'elbas/aws/credentials'
require 'elbas/aws/autoscaling'
require 'elbas/aws/ec2'
require 'elbas/aws_resource'
require 'elbas/ami'
require 'elbas/launch_configuration'

require 'byebug'

module Elbas
end
