require 'mysql2'
require 'dotenv'
require 'json'


class Quiz
  attr_accessor :quiz_id_array

  def initialize
    @client = Mysql2::Client.new(
      username: ENV['DB_USER'],
      password: ENV['DB_PASSWORD'],
      database: ENV['DB_NAME']
    ) # クイズインスタンが生成されたタイミングでDBへの接続設定を行う　子クラスでは継承注意
    @quiz_id_array = [] # ここに５個クイズのIDが保存される
    @quiz_content_hash = {} # 以下ハッシュのキー
    # question, question_png_path, question_ans_gif, options, explanation, question_level, correct_shortcut_id, question_genre_id
    # 解答の正誤をまとめた配列を作る
  end
end

class CreateQuiz < Quiz
  def initialize(level)
    super()
    @level = level
  end

  # ランダムにレベルからクイズIDを取得
  def array_push_quiz_id
    limit = 5 # ここで問題数を設定
    quiz_id_data = @client.query("SELECT quiz_id FROM quiz WHERE question_level = #{@level} ORDER BY RAND() LIMIT #{limit}")
    # 必要な形へ変換
    quiz_id_data.map do |row|
      @quiz_id_array.push(row["quiz_id"])
    end
  end

  # quiz_content_hashをIDから生成
  def push_quiz_contents
    @quiz_id_array.each_with_object({}) do |id, quiz_content_hash|
      quiz_content_data = @client.query("SELECT * FROM quiz WHERE quiz_id = #{id}").first
      next unless quiz_content_data
  
      @quiz_content_hash[id] = {
        "question" => quiz_content_data["question"],
        "question_png_path" => quiz_content_data["question_png_path"],
        "question_ans_gif" => quiz_content_data["question_ans_gif"],
        "options" => quiz_content_data["options"],
        "explanation" => quiz_content_data["explanation"],
        "question_level" => quiz_content_data["question_level"],
        "correct_shortcut_id" => quiz_content_data["correct_shortcut_id"],
        "question_genre_id" => quiz_content_data["question_genre_id"]
      }
      @quiz_content_hash
    end
  end
end