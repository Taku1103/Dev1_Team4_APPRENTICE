require 'webrick'
require 'json'
require 'mysql2'
require 'dotenv'
Dotenv.load

# DBからEpisodesを取得してくるAPI
class Episodes < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(_req, res)
  # MySQL接続情報　ここにenvファイルから呼び出した環境変数を使用
    client = Mysql2::Client.new(
  # host:ENV['DB_HOST'],
    username: ENV['DB_USER'],
    password: ENV['DB_PASSWORD'],
    database: ENV['DB_NAME']
  )
    # res.status = 200
    res['Content-Type'] = 'application/json'
    # フロントサーバーからのアクセスを許可するところ　CORSエラーが出るぞ
    res['Access-Control-Allow-Origin'] = ENV['CLIENT_SERVER']


    result = client.query('SELECT * FROM episodes')
    # 取り出したデータを加工
    data = result.map do |row|
      { id: row['episode_id'], title: row['episode_title'], detaile: row['episode_detail'],
        release_date: row['release_date'] }
    end
    #  HTTPのbodyに加工したデータをJSON形式にして返す
    res.body = data.to_json
    # 送りつけるデータの形式を宣言しておく
  end
end