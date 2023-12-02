require_relative "./classModules/result_class.rb"

require 'webrick'
require 'json'
require 'mysql2'
require 'dotenv'
Dotenv.load

# 名前にサーブレットつけたクラスはAPIに関するもの
class IsQuestionLeftServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(_req, res)
    res.status = 200
    res['Content-Type'] = 'application/json'
    res['Access-Control-Allow-Origin'] = ENV['CLIENT_SERVER']
    next_quiz_class = IsQuestionLeft.new
    next_bool = next_quiz_class.is_next_question
    res.body = next_bool.to_json
  end
end