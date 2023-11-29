# frozen_string_literal: true

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
    # quiz = ResponsQuiz.new() # ここの引数にレベルが入る
    req_quiz_level = _req.query # リクエストのパラメータ(レベル)を取得
    level_value = req_quiz_level['quiz_level']

    create_quiz = CreateQuizId.new(level_value) # レベルを元にクイズを生成
    res.body = create_quiz.get_db_quiz_id #bodyへテスト
  end
end

class CreateQuiz
  attr_accessor :quiz_id_array

  def initialize
    @client = Mysql2::Client.new(
      username: ENV['DB_USER'],
      password: ENV['DB_PASSWORD'],
      database: ENV['DB_NAME']
    ) # クイズインスタンが生成されたタイミングでDBへの接続設定を行う　子クラスでは継承注意
    @quiz_id_array = [] # ここに５個クイズのIDが保存される
    @quiz_content = {} # 以下ハッシュのキー
    # question, question_png_path, question_ans_gif, options, explanation, question_level, correct_shortcut_id, question_genre_id
    # 解答の正誤をまとめた配列を作る
  end
end

class CreateQuizId < CreateQuiz
  def initialize(level)
    super()
    @level = level
  end

  def array_push_quiz_id
    limit = 5 # ここで問題数を設定
    quiz_id_data = @client.query("SELECT quiz_id FROM quiz WHERE question_level = #{@level} ORDER BY RAND() LIMIT #{limit}")
    # 必要な形へ変換
    data = quiz_id_data.map do |row|
      { id: row['quiz_id'] }
    end
    @quiz_id_array.push(data)
    data.to_json
  end

  def push_quiz_contents

  end
end
