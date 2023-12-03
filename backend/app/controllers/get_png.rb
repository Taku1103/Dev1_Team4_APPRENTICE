require_relative './classModules/quiz_class'

require 'webrick'
require 'json'
require 'mysql2'
require 'dotenv'

Dotenv.load

# 名前にサーブレットつけたクラスはAPIに関するもの
class GetPngServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(_req, res)
    res.status = 200
    res['Content-Type'] = 'Content-Type: image/png'
    res['Access-Control-Allow-Origin'] = ENV['CLIENT_SERVER']

    get_png_image_path = GetQuiz.get_png_path

    image_path = "./public/images/png/#{get_png_image_path}"
    image = File.read(image_path, mode: 'rb')

    res.body = image
  end
end