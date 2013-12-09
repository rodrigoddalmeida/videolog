module Videolog
  class Base
    include HTTParty
    ENDPOINT = "http://api.videolog.tv"
    base_uri ENDPOINT

    attr_reader :authorized

    def self.get_json(path, options={}, &block)
      response = get("#{path}.json", options, &block)
      validate_response! response.parsed_response
      response.parsed_response
    end

    def initialize(auth_options={})
      authorize(auth_options)
    end

    def get_json(path, options={}, &block)
      if authorized
        headers = {'Token' => @auth.dev_token}
        headers.merge!({'Autenticacao' => @auth.auth_hash}) unless @auth.auth_hash.nil?
        options = {headers: headers}.merge(options)
      end

      self.class.get_json(path, options, &block)
    end

    def authorize(options={}) # TODO: send some logic to Auth
      @auth = Videolog::Auth.new
      @authorized = false

      unless options[:username].nil? && options[:password].nil?
        @auth.auth_hash = Videolog::Auth.get_auth_hash(options[:username], options[:password])
      end

      unless options[:dev_token].nil?
        @auth.dev_token = options[:dev_token]
        @authorized = true
      end
    end

    def authorize!(options={})
      authorize(options)
      raise AuthorizationNeeded unless authorized
    end

  private

    def self.validate_response!(response)
      status = response["status"]
      if status and status == "error"
        error_message = response["msg"]
        if error_message.nil?
          raise RequestFailed, "Error: no error message"
        else
          raise RequestFailed, "#{status}: #{error_message}"
        end
      end
    end
  end
end
