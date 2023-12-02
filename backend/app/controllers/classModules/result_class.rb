require_relative './quiz_class'

require 'mysql2'
require 'dotenv'
require 'json'

class Result
  @@correct_list = []

  def initialize
    @user_anser = {}
  end
end

class UserAnswer < Result
  def user_input_keep(user_input)
    @user_anser = user_input
  end
end

class CheckAnswers < Result
  def res_quiz_data
    quiz_data = Quiz.to_result_response
    current_id = quiz_data[:quiz_id_array][quiz_data[:quiz_order_num] - 1]
    current_quiz = quiz_data[:quiz_content_hash][current_id]
    current_quiz["解説"] == @user_answer
  end
  

end