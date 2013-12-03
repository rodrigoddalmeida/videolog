require 'rubygems'
require 'bundler'

require 'simplecov'
SimpleCov.start

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'
require 'webmock/test_unit'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'videolog'

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end

def videolog_api_url(path = "")
  "#{Videolog::Base::ENDPOINT}#{path}"
end

def stub_api_request(url, return_filename, request_options=nil, content_type='application/json', status=200, method=:get)
  options = { :body => fixture_file(return_filename) }
  options.merge!({:headers => { 'Content-Type' => content_type }})
  options.merge!({:status => status})
  stub_request(method, videolog_api_url(url)).with(request_options).to_return(options)
end

def stub_api_get(url, return_filename, request_options=nil, content_type='application/json', status=nil)
  stub_api_request(url, return_filename, request_options, content_type, status)
end

def stub_api_post(url, return_filename, request_options=nil, content_type='application/json', status=nil)
  stub_api_request(url, return_filename, request_options, content_type, status, :post)
end

class Test::Unit::TestCase
  def setup
    WebMock.disable_net_connect!
  end
end
