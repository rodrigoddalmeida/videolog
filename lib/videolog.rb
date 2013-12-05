require 'rubygems'
require 'httparty'
require 'virtus'

$:.unshift(File.dirname(__FILE__))
require 'videolog/base'
require 'videolog/auth'
require 'videolog/video'

module Videolog
  class RequestFailed < StandardError; end;
end
