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
('Ctrl+X','行の切り取り (未選択時)',11,1,0,0,0,'x'),
('Ctrl+H','置換',4,1,0,0,0,'h'),
('Ctrl+S','保存する',8,1,0,0,0,'s'),
('Ctrl+F','検索する',4,1,0,0,0,'f'),
('Ctrl+C','コピー',2,1,0,0,0,'c'),
('Shift+Alt+A','ブロックコメントを切り替える',2,0,1,1,0,'a'),
('Ctrl+Shift+L','現在の選択のすべての出現箇所を選択する',5,1,0,1,0,'l');

ALTER TABLE quiz CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
INSERT INTO quiz (
  問題文,
  問題画像パス,
  解答GIFパス,
  解説,
  問題レベル
) VALUES 
('選択操作を行わずカーソルのある行を（変数morning）切り取りたい', 'ctrl_x.png', 'ctrl_x.gif', '行の切り取り(未選択時): 選択したテキストを切り取るために使用されます', 1),
('変数unko_a_num,unko_c_numから変数名a_num,c_numに置換したい。', 'ctrl_h.png', 'ctrl_h.gif', '置換: 特定のテキストを検索して置換したり、複数の置換を一度に行ったりすることができます。', 1),
('変更したファイルを保存したい。', 'ctrl_s.png', 'ctrl_s.gif', '保存: 現在開いているファイルを保存することができます。', 1),
('ランダムな文字列からloveを見つけたい!', 'ctrl_f.png', 'ctrl_f.gif', '検索: 特定のテキストを見つけることができます。', 1),
('せや！ここをコピーしたろ！', 'ctrl_c.png', 'ctrl_c.gif', 'コピー: 選択したテキストやオブジェクトをクリップボードにコピーします。', 1),
('ここのブロックをまとめてコメントアウトしておきたい、どないしよ？', 'shift_alt_a.png', 'shift_alt_a.gif', 'ブロックコメントを切り替える: 選択した行またはブロックのコメントアウトと解除を切り替えるのに便利です。', 1),
('文字列中のloveを変えずに単語区切りのloveだけ別単語に一気に選択変換したい。', 'ctrl_shift_l.png', 'ctrl_shift_l.gif', '現在の選択のすべての出現箇所を選択する: 選択されたテキストまたはカーソル位置にある単語と同じ出現箇所を一括で選択するために使用されます。', 1);

insert into quiz_short(ショートカットID,クイズID)
values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7);