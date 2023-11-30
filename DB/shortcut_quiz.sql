DROP DATABASE IF EXISTS vscode_shortcut_quiz;
CREATE DATABASE IF NOT EXISTS vscode_shortcut_quiz;
USE vscode_shortcut_quiz;

DROP TABLE IF EXISTS shortcut_genre,
                     shortcut,
                     quiz,
                     quiz_short;



-- Shortcut Genre テーブルの作成
CREATE TABLE shortcut_genre (
    ショートカットジャンルID INT AUTO_INCREMENT PRIMARY KEY,
    ショートカットジャンル名 VARCHAR(50) NOT NULL
);

-- Shortcut テーブルの作成
CREATE TABLE shortcut (
    ショートカットID INT AUTO_INCREMENT PRIMARY KEY,
    ショートカットコマンド VARCHAR(50) NOT NULL,
    ショートカット説明 TEXT,
    ショートカットジャンルID INT,
    Ctrl真偽値 TINYINT default 0,
    Alt真偽値 TINYINT DEFAULT 0,
    Shift真偽値 TINYINT DEFAULT 0,
    CtrlK真偽値 TINYINT DEFAULT 0,
    キー VARCHAR(50),
    FOREIGN KEY (ショートカットジャンルID) REFERENCES shortcut_genre(ショートカットジャンルID)
);

-- Quiz テーブルの作成
CREATE TABLE quiz (
    クイズID INT AUTO_INCREMENT PRIMARY KEY,
    問題文 TEXT NOT NULL,
    問題画像パス TEXT,
    解答GIFパス TEXT,
    解説 TEXT,
    問題レベル INT
);

-- Quiz-Shortcut 関連テーブルの作成
CREATE TABLE quiz_short (
    ショートカットID INT,
    クイズID INT,
    PRIMARY KEY (ショートカットID, クイズID),
    FOREIGN KEY (ショートカットID) REFERENCES shortcut(ショートカットID),
    FOREIGN KEY (クイズID) REFERENCES quiz(クイズID)
);
