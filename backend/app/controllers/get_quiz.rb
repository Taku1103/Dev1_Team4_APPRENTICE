require 'webrick'
require 'json'
require 'mysql2'
require 'dotenv'

Dotenv.load

# 名前にサーブレットつけたクラスはAPIに関するもの
class GetQuizServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(_req, res)
    res.status = 200
    res['Content-Type'] = 'application/json'
    res['Access-Control-Allow-Origin'] = ENV['CLIENT_SERVER']
    
    get_class = GetQuiz.new
    quiz_contents = get_class.get_quiz_contents
    
    res.body = quiz_contents.to_json
  end
end