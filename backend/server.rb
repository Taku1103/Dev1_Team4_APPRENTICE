# frozen_string_literal: true

# app/controllerにあるファイルを読み込む
require_relative './app/controllers/quiz'
require_relative './app/controllers/episodes'

require 'webrick'
require 'json'
require 'mysql2'
require 'dotenv'
Dotenv.load

# ポート番も環境変数から呼び出し
server = WEBrick::HTTPServer.new(Port: ENV['PORT'])

# ログを出す部分、多分ここはそんなに考えなくていい
server.config[:AccessLog] = [
  [$stderr, WEBrick::AccessLog::COMMON_LOG_FORMAT],
  [$stderr, WEBrick::AccessLog::COMBINED_LOG_FORMAT]
]

# 既存のエンドポイントにサーブレットをマウント
server.mount('/quiz', Quiz)
server.mount('/episodes', Episodes)

# シャットダウンに必要な記述
trap('INT') { server.shutdown }

server.start
