require 'helper'

class VideoTest < Test::Unit::TestCase
  
  context "#find_video" do
    
    should "retrieve info of the selected video" do
      stub_api_get('/video/715519.json', 'video/find.json')
      video = Videolog::Video.new.find("715519")

      assert_equal Hash, video.class
      assert_equal 715519, video['video']['id']
    end

    should "get an error if video doesn't exist" do
      stub_api_get('/video/12345678.json', 'video/unknown_video.json')

      assert_raise Videolog::RequestFailed do
        Videolog::Video.new.find("12345678")
      end
    end
  end
end
