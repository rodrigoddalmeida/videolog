require 'rubygems'
require 'httparty'

$:.unshift(File.dirname(__FILE__))
require 'videolog/base'
require 'videolog/auth'
require 'videolog/video'

module Videolog
  class AuthorizationNeeded < StandardError; end;
  class RequestFailed < StandardError; end;
end
