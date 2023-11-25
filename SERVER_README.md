# http_test_server
### バックエンド
1. backendディレクトリに移動しRubyが動く環境で`bundle install`を実行して下さい
2. bundlerがインストールされていない場合は`gem install bundler`でインストールして下さい
3. `.env`にデータベースの接続に必要な情報を書いて下さい。`exsample_env.md`がテンプレートになります。
4. `ruby server.rb`でWEBrickを起動させます。
### フロントエンド
1. frontendディレクトリに移動して下さい。
2. node.jsが動く環境を用意しnpmが使えるようにして下さい。
3. `npm install`でpackage.jsonのライブラリがインストールされます。
4. `http-server -p 5050`でhttp-serverを起動させて下さい。