require 'helper'

class VideoTest < Test::Unit::TestCase
  
  context ".find" do
    
    should "retrieve info of the selected video" do
      stub_api_get('/video/715519.json', 'video/find.json')
      video = Videolog::Video.find("715519")

      assert_equal Videolog::Video, video.class
      assert_equal Fixnum, video.ordem.class
      assert_equal Fixnum, video.id_canal.class
      assert_equal String, video.thumb.class
      assert_equal String, video.mobile.class
      assert_equal String, video.url_mp4.class
      assert_equal String, video.duracao.class
      assert_equal String, video.uri.class
      assert_equal String, video.uri_videos_relacionados.class
      assert_equal String, video.texto.class
      assert_equal Fixnum, video.visitas.class
      assert_equal Fixnum, video.sinc.class
      assert_equal Fixnum, video.usuario_id.class
      assert_equal DateTime, video.criacao.class
      assert_equal String, video.link.class
      assert_equal String, video.privacidade.class
      assert_equal String, video.titulo.class
      assert_equal String, video.embed.class
      assert_equal String, video.uri_comentarios.class
      assert_equal Fixnum, video.id.class
    end

    should "get an error if video doesn't exist" do
      stub_api_get('/video/12345678.json', 'video/unknown_video.json')

      assert_raise Videolog::RequestFailed do
        Videolog::Video.find("12345678")
      end
    end
  end
end
