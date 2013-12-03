module Videolog
  class Auth < Videolog::Base

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
  end
end
