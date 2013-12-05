module Videolog
  class Base
    include HTTParty
    ENDPOINT = "http://api.videolog.tv"
    base_uri ENDPOINT

    def self.get_json(path, options={}, &block)
      response = get("#{path}.json", options, &block)
      json_response = JSON.parse(response.body)
      validate_response! json_response
      json_response
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
