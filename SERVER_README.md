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
4. `npm run start`でhttp-serverを起動させて下さい。

--- 以下ディレクトリ見取り図　落として全画面で見て下さい　崩れます ---

フロント
project-root/
|-- index.html       // アプリケーションのエントリーポイント ここがサーバー立ち上げて一番最初に表示されるHTMLファイルだよ
|-- assets/          // 画像、フォント、その他の静的ファイル　ここにその他のHTMLファイルを入れていくよ
|-- css/             // CSSファイル　CSSファイルだね。
|-- js/              // JavaScriptファイル　JSファイルだよ　HTMLから呼ぶJSを書いていくよ　テストで書いたファイルがあるから書き換えてね
|-- node_modules/    // Node.jsモジュール（.gitignoreで無視される）　これは勝手に生成されるからいじらない
|-- .gitignore       // Gitの無視設定　
|-- package.json     // Node.jsプロジェクトの設定ファイル　これもいじらない


バックエンド
project-root/
|-- app/                # アプリケーションのメインコード
|   |-- controllers/    # APIエンドポイントのコントローラー　ここにserver.rbから呼び出す処理を書いていく。
|   |-- models/         # データモデル　これいるか？
|-- config/             # 設定ファイル　いる？データーベースとかの設定とか環境変数とか入れるの？よくわからん
|-- db/                 # データベース関連のファイル　ここもよくわからんけどSQLファイルとかか？
|-- public/             # 静的ファイル（ドキュメント、画像、その他の公開ファイル）ここに画像ファイルを格納していくよ
|-- .gitignore          # Gitの無視設定
|-- Gemfile             # Ruby gemsの依存関係ファイル
|-- Gemfile.lock        # Ruby gemsの依存関係のロックファイル
|-- server.rb           # WEBrickサーバーの設定ファイル　これがサーバー立ち上げた時のメインファイル。コントローラで作ったファイルを呼ぶよ
