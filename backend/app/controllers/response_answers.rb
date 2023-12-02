require_relative './classModules/result_class'

require 'webrick'
require 'json'
require 'mysql2'
require 'dotenv'
Dotenv.load

# 名前にサーブレットつけたクラスはAPIに関するもの
class ResponseAnswerServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(_req, res)
    res.status = 200
    res['Content-Type'] = 'application/json'
    res['Access-Control-Allow-Origin'] = ENV['CLIENT_SERVER']
    check_answer_class = CheckAnswers.new
    answer_hash = check_answer_class.res_answer_data
    res_result = check_answer_class.check_answer(answer_hash)
    res.body = res_result.to_json
  end
end
