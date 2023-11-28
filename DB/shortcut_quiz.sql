-- 上書き設定
DROP DATABASE IF EXISTS vscode_shortcut_quiz;
CREATE DATABASE IF NOT EXISTS vscode_shortcut_quiz;
USE vscode_shortcut_quiz;

DROP TABLE IF EXISTS shortcut_genre,
                     shortcut,
                     quiz,
                     quiz_short;
                     


-- テーブル定義

-- shortcut_genreテーブルの作成
CREATE TABLE IF NOT EXISTS shortcut_genre (
    shortcut_genre_id 	INT AUTO_INCREMENT,
    short_genre_name	VARCHAR(50),
    PRIMARY KEY (shortcut_genre_id)
);

-- Shortcutテーブルの作成
CREATE TABLE IF NOT EXISTS shortcut (
    shortcut_id INT AUTO_INCREMENT,
    shortcut_command VARCHAR(50),
    description TEXT,
    shortcut_genre_id INT,
    PRIMARY KEY (shortcut_id)
);

-- Quizテーブルの作成
CREATE TABLE IF NOT EXISTS quiz (
    quiz_id INT AUTO_INCREMENT,
    question TEXT,
    question_png_path TEXT,
    question_ans_gif TEXT,
    options JSON,
    explanation TEXT,
    question_level INT,
    correct_shortcut_id INT,
    question_genre_id INT,
    PRIMARY KEY(quiz_id)
);

-- quiz-shortテーブルの作成
CREATE TABLE IF NOT EXISTS quiz_short (
    quiz_id INT,
    shortcut_id INT,
    PRIMARY KEY (quiz_id , shortcut_id)
);

-- 外部キー設定
ALTER TABLE shortcut
    ADD FOREIGN KEY (shortcut_genre_id) REFERENCES shortcut_genre (shortcut_genre_id);

ALTER TABLE quiz
    ADD FOREIGN KEY (correct_shortcut_id) REFERENCES Shortcut(shortcut_id),
    ADD FOREIGN KEY (question_genre_id) REFERENCES shortcut_genre(shortcut_genre_id);

ALTER TABLE quiz_short
    ADD FOREIGN KEY (quiz_id) REFERENCES Quiz (quiz_id),
    ADD FOREIGN KEY (shortcut_id) REFERENCES Shortcut (shortcut_id);