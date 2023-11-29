require 'webrick'
require 'json'
require 'mysql2'
require 'dotenv'
Dotenv.load

class CreateQuizServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(_req, res)
    res.status = 200
    res['Content-Type'] = 'application/json'
    res['Access-Control-Allow-Origin'] = ENV['CLIENT_SERVER']
    # quiz = ResponsQuiz.new() # ここの引数にレベルが入る
    req_quiz_level = _req.query # リクエストのパラメータ(レベル)を取得
    level_value = req_quiz_level["quiz_level"]
    # CreateQuiz.new(level_value) # レベルを元にクイズを生成
    p level_value
    res.body = level_value.to_json
  end
end

class Quiz
  attr_accessor :quiz_id_array
  def initialize
    @client = Mysql2::Client.new(
      username: ENV['DB_USER'],
      password: ENV['DB_PASSWORD'],
      database: ENV['DB_NAME']
    ) # クイズインスタンが生成されたタイミングでDBへの接続設定を行う　子クラスでは継承注意
    @quiz_id_array = [] #ここに５個クイズのIDが保存される
    # 解答の正誤をまとめた配列を作る
  end
end

class CreateQuiz < Quiz
  def initialize(level)
    super(@client,@quiz_id_array)
    @level = level
  end
  def get_db_quiz_id
    result = @client.query("SELECT quiz_id FROM quiz WHERE question_level=#{@level}") # paramから受け取ったレベルで検索
    shuffle_array = result.shuffle!
    # 必要な形へ変換
    quiz_limit = 5 #ここで問題数を設定
    data = shuffle_array[1..quiz_limit].map do |row|
      { id: row['quiz_id']}
    end
    @quiz_id_array.push(data.to_json)
  end
end