require 'helper'

class BaseTest < Test::Unit::TestCase

  context "videolog base" do

    context ".get_json" do

      should "return a hash if the request is .json" do
        stub_api_get("/get_success.json", "base/get_success.json")
        get_request = Videolog::Base.get_json("/get_success")

        assert_equal get_request.class, Hash
      end

      should "raise a RequestFailed" do
        stub_api_get("/get_failure.json", "base/get_failure.json")

        assert_raise Videolog::RequestFailed do
          Videolog::Base.get_json("/get_failure")
        end
      end
    end

    context "authorization" do

      context "#authorize" do
        should "not be authorized when no auth info is provided" do
          base = Videolog::Base.new

          assert_equal false, base.authorized
        end

        should "be authorized when no auth info is provided" do
          base = Videolog::Base.new(dev_token: '12345678')

          assert_equal true, base.authorized
        end
      end

      context "#authorize!" do
        should "raise error" do
          assert_raise Videolog::AuthorizationNeeded do
            Videolog::Base.new.authorize!
          end
        end
      end
    end
  end
end
