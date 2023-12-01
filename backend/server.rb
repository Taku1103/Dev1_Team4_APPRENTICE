# frozen_string_literal: true

# app/controllerにあるファイルを読み込む
require_relative './app/controllers/create_quiz'
require_relative './app/controllers/get_quiz'
require_relative './app/controllers/user_answer'

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
# server.mount('/response_answer', ResponseAnserServlet)
# server.mount('/result', ResultServlet)

# シャットダウンに必要な記述
trap('INT') { server.shutdown }

# 起動する文言
server.start
