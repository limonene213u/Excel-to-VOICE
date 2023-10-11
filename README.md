# Excel-to-VOICE

## これはなに？
![image](https://github.com/limonene213u/Excel-to-VOICE/assets/57677762/cb0e4f2f-ce6c-4ee4-9627-55b828a7f522)


Flaskで作ったVOICEVOXの読み上げ支援アプリです。
個人的に作ったものですが、公開します。
個人のテキトー自動化のためのスクリプトが元ネタなので、いろいろくそテキトーかもしれません。

開発環境&テスト環境はIntel MacBookPro 16inch（2019、macOS Sonoma 14.0）、OrbStackです。

※OrbStackのページ:
https://docs.orbstack.dev/

※VOICEVOX Engineのリポジトリ：
https://github.com/VOICEVOX/voicevox_engine

## 既知の問題とその対処方法
現在、合成後の音声にクリックノイズが入る問題があります。
このクリックノイズを取り除くためにはAudacityを用いるとよいです。

エフェクト＞Noise Removal and Repair＞クリックノイズの削除

<img width="522" alt="image" src="https://github.com/limonene213u/Excel-to-VOICE/assets/57677762/51545ff3-e50b-40ce-82bd-d6f2e9395b2e">

これで基本的には大丈夫ですが、冒頭のノイズのみ残る場合があります。その場合、冒頭だけ数ミリ秒を取り除いてください。

## 使い方
 1. このリポジトリをクローンして、docker-composeで立ち上げます。
 2. ExcelファイルのA列とB列に読み上げさせたい文章を書きます。
 3. Excelファイルをアップロードします。アップロードすると処理が開始されます。
 4. 処理が終了するとダウンロードのためのポップアップが出ますので、PCの任意の場所に保存します。

ただし、１行目（A1、B1）はタイトルヘッダーとして機能しますので、読み上げは２列目以降（A2、B2）です。

また、チェックボックスにチェックを入れることでA列のみの連続読み上げも可能です。

## オプション
内蔵でCPU版のVOICEVOX ENGINEを搭載していますが、お使いのVOICEVOXを立ち上げておくと、アプリ側で処理することができます。
普段の設定（ユーザー辞書など）を使用することができます。

うまくいかない場合、

http://localhost:50021/setting

にアクセスしてCORS設定してみてください。
ちゃんと設定すればたぶん必要ないとは思いますが、いちおうnginx（リバースプロキシとして使用可能）の設定もコメントアウトしたうえで残しておきます。

また、Docker DesktopやOrbStackなどを使用せず、LinuxやWSLで実行する場合は以下の設定を変更してください。

```app.py
@app.route('/upload', methods=['POST'])
def upload_file():
    file = request.files['file']
    engine_option = request.form['engine-option']
    speaker_id_a = request.form['speaker-id-a']  # A列の話者IDを取得する
    speaker_id_b = request.form['speaker-id-b']  # B列の話者IDを取得する
    single_column = request.form.get('single_column') == 'on'  # チェックボックスの値を取得する
    engine_url = 'http://host.docker.internal:50021' if engine_option == 'local' else 'http://voicevox:50021'
                 #↑ここのhost.docker.internalをホストのIPに変更
```

## Cloudflareなどを使用する場合にタイムアウトする問題について
Cloudflareはデフォルトでは30秒でタイムアウトするので、Additional Settingsでタイムアウトまでの時間を引き伸ばしてください。
