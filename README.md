# Excel-to-VOICE

現在、合成後の音声にクリックノイズが入る問題があります。
このクリックノイズを取り除くためにはAudacityを用いるとよいです。

エフェクト＞Noise Removal and Repair＞クリックノイズの削除

<img width="522" alt="image" src="https://github.com/limonene213u/Excel-to-VOICE/assets/57677762/51545ff3-e50b-40ce-82bd-d6f2e9395b2e">

## 使い方
このリポジトリをクローンして、docker-composeで立ち上げます。
ExcelファイルのA列とB列に読み上げさせたい文章を書きます。
Excelファイルをアップロードします。アップロードすると処理が開始されます。
処理が終了するとダウンロードのためのポップアップが出ますので、PCの任意の場所に保存します。

## オプション
内蔵でCPU版のVOICEVOX ENGINEを搭載していますが、お使いのVOICEVOXを立ち上げておくと、アプリ側で処理することができます。
うまくいかない場合、

http://localhost:50021/setting

にアクセスしてCORS設定してみてください。
