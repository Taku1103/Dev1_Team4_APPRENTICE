require "webrick"

class Console < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(_req, res)
    res.status = 200
    res['Content-Type'] = 'application/json'
    res['Access-Control-Allow-Origin'] = ENV['CLIENT_SERVER']

    # レスポンスの中身
    post_data = 'get_backend_data'

    # ここで受け取ったデータを処理する
    res.body = post_data.to_json
  end
end