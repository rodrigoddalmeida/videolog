module Videolog
  class Base
    include HTTParty
    ENDPOINT = "http://api.videolog.tv"
    base_uri ENDPOINT
  end
end
