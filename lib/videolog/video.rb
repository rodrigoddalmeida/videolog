module Videolog
  class Video < Videolog::Base
    include Virtus.model

    attribute :ordem, Fixnum
    attribute :id_canal, Fixnum
    attribute :thumb, String
    attribute :mobile, String
    attribute :url_mp4, String
    attribute :duracao, String
    attribute :uri, String
    attribute :uri_videos_relacionados, String
    attribute :texto, String
    attribute :visitas, Fixnum
    attribute :sinc, Fixnum
    attribute :usuario_id, Fixnum
    attribute :criacao, DateTime
    attribute :link, String
    attribute :privacidade, String
    attribute :titulo, String
    attribute :embed, String
    attribute :uri_comentarios, String
    attribute :id, Fixnum

    def self.find(video_id)
      response = get_json("/video/#{video_id}")
      new(response['video'])
    end
  end
end
