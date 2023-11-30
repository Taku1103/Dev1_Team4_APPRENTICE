# frozen_string_literal: true
require_relative './classModules/quiz_class'

require 'webrick'
require 'json'
require 'mysql2'
require 'dotenv'
Dotenv.load

# 名前にサーブレットつけたクラスはAPIに関するもの
class CreateQuizServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(_req, res)
    res.status = 200
    res['Content-Type'] = 'application/json'
    res['Access-Control-Allow-Origin'] = ENV['CLIENT_SERVER']

    req_quiz_level = _req.query # リクエストのパラメータ(レベル)を取得
    level_value = req_quiz_level['quiz_level']

    create_quiz = CreateQuiz.new(level_value) # レベルを元にクイズを生成
    create_quiz.array_push_quiz_id
    contens_data = create_quiz.push_quiz_contents
    res.body = contens_data.to_json
  end
end
