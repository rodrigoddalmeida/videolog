module Videolog
  class Auth < Videolog::Base

    attr_accessor :auth_hash, :dev_token

    def self.get_auth_hash(username, password)
      response = post('/usuario/login', body: {
        login: username,
        senha: password
      })

      if response.body =~ /Autenticacao/
        response.body[/Autenticacao=(?<auth_hash>.*)/, 'auth_hash']
      else
        nil
      end
    end

    def initialize(options={})
      @auth_hash = options[:auth_hash]
      @dev_token = options[:dev_token]
    end
  end
end
