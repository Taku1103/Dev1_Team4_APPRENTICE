require_relative './classModules/result_class'

require 'webrick'
require 'json'
require 'mysql2'
require 'dotenv'
Dotenv.load

# 名前にサーブレットつけたクラスはAPIに関するもの
class UserAnswerServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(_req, res)
    res.status = 200
    res['Content-Type'] = 'application/json'
    res['Access-Control-Allow-Origin'] = ENV['CLIENT_SERVER']

    user_answer_input = _req.query
    user_answer_class= UserAnswer.new
    input = user_answer_class.user_input_keep(user_answer_input)
    msg = {message: "send_user_input"}
    res.body = input.to_json
  end
end
