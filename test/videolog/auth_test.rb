require 'helper'

class AuthTest < Test::Unit::TestCase

  context "videolog auth" do

    context ".new" do
      should "initialize with the provided options" do
        base = Videolog::Auth.new(auth_hash: '1234567890', dev_token: 'ABCDEF')

        assert_equal '1234567890', base.auth_hash
        assert_equal 'ABCDEF', base.dev_token
      end
    end

    context ".get_auth_hash" do

      should "retrieve and return an auth hash" do
        stub_api_post("/usuario/login", "auth/good_hash.txt", {body: "login=u&senha=p"}, "text/html")
        auth_hash = Videolog::Auth.get_auth_hash("u", "p")

        assert_equal '1234567890', auth_hash
      end

      should "retrieve nil if unsuccessful" do
        stub_api_post("/usuario/login", "auth/failed_hash.txt", {body: "login=u&senha=%3Ap"}, "text/html")
        auth_hash = Videolog::Auth.get_auth_hash("u", ":p")

        assert_nil auth_hash
      end
    end
  end
end
