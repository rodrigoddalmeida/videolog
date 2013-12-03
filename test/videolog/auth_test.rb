require 'helper'

class AuthTest < Test::Unit::TestCase

  context "videolog auth" do
    
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
