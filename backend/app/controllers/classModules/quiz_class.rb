require 'mysql2'
require 'dotenv'
require 'json'


class Quiz
  attr_accessor :quiz_id_array,:quiz_content_hash
  @@quiz_id_array = [] # ここに５個クイズのIDが保存される
  @@quiz_content_hash = {} # 以下ハッシュのキー
  @@quiz_order_num = 0 #何問目かの初期値
  @@quiz_order_max = 5 # ここで問題数を設定
  @@current_quiz = {}
  
  def initialize
    @client = Mysql2::Client.new(
      username: ENV['DB_USER'],
      password: ENV['DB_PASSWORD'],
      database: ENV['DB_NAME']
      ) # クイズインスタンが生成されたタイミングでDBへの接続設定を行う　子クラスでは継承注意

    # 解答の正誤をまとめた配列を作る
  end

  def self.to_result_response
    {
      sql_connection: @client,
      quiz_id_array: @@quiz_id_array,
      quiz_content_hash: @@quiz_content_hash,
      quiz_order_num: @@quiz_order_num,
      quiz_order_max: @@quiz_order_max
    }
  end
  
end

class CreateQuiz < Quiz
  def initialize(level)
    super()
    @level = level
    @@quiz_order_num = 0 # 作成時に０に戻す
  end

  # ランダムにレベルからクイズIDを取得
  def array_push_quiz_id
    @@quiz_id_array = [] # 初期化
    quiz_id_data = @client.query(
      "SELECT クイズID
      FROM quiz
      WHERE 問題レベル = #{@level} 
      ORDER BY RAND() 
      LIMIT #{@@quiz_order_max}"
      )
    # @client.close if @client
    # クイズIDを配列に格納
    quiz_id_data.map do |row|
      @@quiz_id_array.push(row["クイズID"])
    end
  end

  # quiz_content_hashをIDから生成
  def push_quiz_contents
    @@quiz_content_hash = {} # 初期化
    @@quiz_id_array.each_with_object({}) do |id, quiz_content_hash|
      quiz_content_data = @client.query(
        "SELECT *
        FROM quiz q
        LEFT JOIN quiz_short qs ON qs.クイズID = q.クイズID
        LEFT JOIN shortcut sc ON sc.ショートカットID = qs.ショートカットID
        LEFT JOIN shortcut_genre sg ON sg.ショートカットジャンルID = sc.ショートカットジャンルID
        WHERE q.クイズID = #{id}"
        ).first
      next unless quiz_content_data
  
      @@quiz_content_hash[id] = {
        "問題レベル" => quiz_content_data["問題レベル"],
        "問題文" => quiz_content_data["問題文"],
        "問題画像パス" => quiz_content_data["問題画像パス"],
        "解答GIFパス" => quiz_content_data["解答GIFパス"],
        "ショートカットジャンル名" => quiz_content_data["ショートカットジャンル名"]
      }
    end
  end
end

# quiz_id_arrayを回してquiz_content_hashの中身を１個つづ取り出す
class GetQuiz < Quiz
  
    @@png_path = ""
    @@gif_path = ""
    

  def get_quiz_contents
    if @@quiz_order_num < @@quiz_order_max
      current_quiz = @@quiz_content_hash[@@quiz_id_array[@@quiz_order_num]]
      @@png_path = current_quiz["問題画像パス"]
      @@gif_path = current_quiz["解答GIFパス"]
      quiz_num = @@quiz_order_num += 1
      current_quiz['問題数'] = quiz_num
      current_quiz
    else
      @@quiz_order_num = 0
    end
  end

  def self.get_png_path
    @@png_path
  end

  def self.get_gif_path
    @@gif_path
  end
end