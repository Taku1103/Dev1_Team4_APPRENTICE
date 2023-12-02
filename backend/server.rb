# frozen_string_literal: true

# app/controllerにあるファイルを読み込む
require_relative './app/controllers/create_quiz'
require_relative './app/controllers/get_quiz'
require_relative './app/controllers/get_png'
require_relative './app/controllers/get_gif'
require_relative './app/controllers/user_answer'
require_relative './app/controllers/response_answers'
require_relative './app/controllers/is_question_left'
require_relative './app/controllers/result'


require 'webrick'
require 'json'
require 'mysql2'
require 'dotenv'
Dotenv.load

# ポートの設定場所　環境変数からポート番号呼び出してるよ
server = WEBrick::HTTPServer.new(Port: ENV['PORT'])

# ログを出す部分、多分ここはそんなに考えなくていい
server.config[:AccessLog] = [
  [$stderr, WEBrick::AccessLog::COMMON_LOG_FORMAT],
  [$stderr, WEBrick::AccessLog::COMBINED_LOG_FORMAT]
]

# 既存のエンドポイントにサーブレットをマウント
# ここでバックエンドのどこにアクセスするとデータが持ってこれるか決めるよ
#  server.mount("ここにURL","ここにコントローラーに書き出したクラスを指定")
server.mount('/create_quiz', CreateQuizServlet)
server.mount('/get_quiz', GetQuizServlet)
server.mount('/user_answer', UserAnswerServlet)
server.mount('/response_answer', ResponseAnswerServlet)
server.mount('/result', ResultServlet)
server.mount('/is_next_question', IsQuestionLeftServlet)
server.mount('/get_png', GetPngServlet)
server.mount('/get_gif', GetGifServlet)

# シャットダウンに必要な記述
trap('INT') { server.shutdown }

# 起動する文言
server.start
