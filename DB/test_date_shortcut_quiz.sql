USE vscode_shortcut_quiz;
ALTER TABLE shortcut_genre CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
insert into shortcut_genre(ショートカットジャンル名)
values 
('General'),
('Basic editing'),
('Navigation'),
('Search and replace'),
('Multi-cursor and selection'),
('Rich languages editing'),
('Editor management'),
('File management'),
('Display'),
('Debug'),
('Integrated terminal');

ALTER TABLE shortcut CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
insert into shortcut(ショートカットコマンド,ショートカット説明,ショートカットジャンルID,Ctrl真偽値,Alt真偽値,Shift真偽値,CtrlK真偽値,キー)
values
('Ctrl+F','検索',4,1,0,0,0,'f'),
('Ctrl+H','置換',4,1,0,0,0,'h'),
('Ctrl+N','新規ファイル',8,1,0,0,0,'n'),
('Ctrl+S','保存',8,1,0,0,0,'s'),
('Ctrl+`','統合ターミナルを表示',11,1,0,0,0,'`'),
('Ctrl+V','アクティブターミナルにペースト',11,1,0,0,0,'v');

ALTER TABLE quiz CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
INSERT INTO quiz (
  問題文,
  問題画像パス,
  解答GIFパス,
  解説,
  問題レベル
) VALUES 
('とある変数がどこにあるのか探したくなった', 'Dev1_Team4_APPRENTICE/backend/public/images/jpg', 'Dev1_Team4_APPRENTICE/backend/public/images/gif', 'Ctrl+F', 1),
('長いコードの中で特定の単語を変更する必要が生じた', 'Dev1_Team4_APPRENTICE/backend/public/images/jpg', 'Dev1_Team4_APPRENTICE/backend/public/images/gif', 'Ctrl+H', 1),
('何か新しいアイデアを思いついたとき、すばやく新しいドキュメントを開始したい。', 'Dev1_Team4_APPRENTICE/backend/public/images/jpg', 'Dev1_Team4_APPRENTICE/backend/public/images/gif', 'Ctrl+N', 1),
('編集中のファイルをとりあえず保存したい', 'Dev1_Team4_APPRENTICE/backend/public/images/jpg', 'Dev1_Team4_APPRENTICE/backend/public/images/gif', 'Ctrl+S', 1),
('コードを書いているときに、サーバーを起動したり、スクリプトを実行したりするために、手早くターミナルにアクセスしたい', 'Dev1_Team4_APPRENTICE/backend/public/images/jpg', 'Dev1_Team4_APPRENTICE/backend/public/images/gif', 'Ctrl+`', 1),
('有用なコマンドを見つけコピーしてきたので貼り付けたい', 'Dev1_Team4_APPRENTICE/backend/public/images/jpg', 'Dev1_Team4_APPRENTICE/backend/public/images/gif', 'Ctrl+V', 1);

insert into quiz_short(ショートカットID,クイズID)
values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6);