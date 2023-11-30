require 'webrick'
require 'json'
require 'mysql2'
require 'dotenv'
Dotenv.load

# 名前にサーブレットつけたクラスはAPIに関するもの
class UserAnswerServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(_req, res)
    res.status = 200
    res['Access-Control-Allow-Origin'] = 'http://127.0.0.1:5050'
    res['Access-Control-Allow-Methods'] = 'POST, OPTIONS'
    res['Access-Control-Allow-Headers'] = 'Content-Type'
    res['Access-Control-Max-Age'] = '3600'    
    res['Content-Type'] = 'application/json'

    user_answer = _req.query

    res.body = user_answer.to_json
  end
end