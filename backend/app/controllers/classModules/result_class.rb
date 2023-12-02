# frozen_string_literal: true

require_relative './quiz_class'

require 'mysql2'
require 'dotenv'
require 'json'

class Result
  # 正解した結果が入る
  @@correct_result = []
  @@user_answer = {}
  @@quiz_num = 0


  def initialize
    @client = Mysql2::Client.new(
      username: ENV['DB_USER'],
      password: ENV['DB_PASSWORD'],
      database: ENV['DB_NAME']
    )
  end
end

class UserAnswer < Result
  def user_input_keep(user_input)
    # 呼び出し毎に空にする
    @@user_answer = {}
    # string型のboolをbool型に変換してハッシュに入れる
    keys_to_convert_bool = ["ctrl", "alt", "shift", "ctrl_k"]
    keys_to_convert_bool.each do |key|
      value = user_input[key]
      @@user_answer[key] = value == "true" ? true : false
    end
    input_key = user_input['key'].downcase
    @@user_answer['key'] = input_key[0,1]
    @@user_answer
  end
end


class CheckAnswers < Result
  def res_answer_data
    quiz_data = Quiz.to_result_response
    # どのクイズを行なっているか
    @@quiz_num = quiz_data[:quiz_order_num]
    current_id = quiz_data[:quiz_id_array][quiz_data[:quiz_order_num]]
    # quiz_data[:quiz_content_hash][current_id]
    shortcut_db_data = @client.query(
      "SELECT *
      FROM quiz q
      LEFT JOIN quiz_short qs ON qs.クイズID = q.クイズID
      LEFT JOIN shortcut sc ON sc.ショートカットID = qs.ショートカットID
      LEFT JOIN shortcut_genre sg ON sg.ショートカットジャンルID = sc.ショートカットジャンルID
      WHERE q.クイズID = #{current_id}"
    )

    correct_hash = {}
    shortcut_db_data.each do |row|
      correct_hash = {
        'Ctrl真偽値' => row['Ctrl真偽値'],
        'Alt真偽値' => row['Alt真偽値'],
        'Shift真偽値' => row['Shift真偽値'],
        'CtrlK真偽値' => row['CtrlK真偽値'],
        'キー' => row['キー']
      }
    end

    answer_explain_hash = {}
    shortcut_db_data.each do |row|
      answer_explain_hash = {
        '問題レベル'=> row['問題レベル'],
        'ショートカットジャンル名' => row['ショートカットジャンル名'],
        '解答GIFパス' => row['解答GIFパス'],
        '解説' => row['解説'],
        'ショートカットコマンド' => row['ショートカットコマンド'],
        'ショートカット説明' => row['ショートカット説明']
      }
    end
    answer_hash = {correct_hash:correct_hash,answer_explain_hash:answer_explain_hash}
  end

  def check_answer(answer_hash)
    # 0 1 をboolに変換
    keys_to_convert = ["Ctrl真偽値", "Alt真偽値", "Shift真偽値", "CtrlK真偽値"]

    keys_to_convert.each do |key|
      value = answer_hash[:correct_hash][key]
      answer_hash[:correct_hash][key] = value != 0
    end

    # @@correct_listの初期化
    correct_list = []

    # 入力値と答えが合っているかの判定
    keys_to_convert_bool = ["ctrl", "alt", "shift"]

    keys_to_convert_bool.each do |key|
      if answer_hash[:correct_hash]["#{key.capitalize}真偽値"] === @@user_answer[key]
        correct_list.push(true)
      else
        correct_list.push(false)
      end
    end

    if answer_hash[:correct_hash]["CtrlK真偽値"] === @@user_answer['ctrl_k']
      correct_list.push(true)
    else
      correct_list.push(false)
    end
    
    if answer_hash[:correct_hash]['キー'] === @@user_answer['key']
      correct_list.push(true)
    else
      correct_list.push(false)
    end

    result = !correct_list.include?(false)

    @@correct_result.push(true ? true : false)

    answer_hash[:answer_explain_hash]['解答結果'] ||= result
    answer_hash[:answer_explain_hash]['ユーザー解答'] ||= @@user_answer
    answer_hash[:answer_explain_hash]['問題数'] ||= @@quiz_num
    answer_hash[:answer_explain_hash]
  end

  class FinalResult < Result
    def total_correct
      a = @@correct_result
      p a
    end
  end
end