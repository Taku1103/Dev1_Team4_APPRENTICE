require_relative './classModules/result_class'

require 'webrick'
require 'json'
require 'mysql2'
require 'dotenv'
Dotenv.load

# 名前にサーブレットつけたクラスはAPIに関するもの
class ResultServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(_req, res)
    res.status = 200
    res['Content-Type'] = 'application/json'
    res['Access-Control-Allow-Origin'] = ENV['CLIENT_SERVER']

    r = FinalResult.new
    t = r.total_correct
    msg = {message: "send_user_input"}
    res.body = t.to_json
  end
end