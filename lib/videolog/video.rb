module Videolog
  class Video < Videolog::Base

    # interface requests
    def find(video_id)
      get_json("/video/#{video_id}")
    end
  end
end
