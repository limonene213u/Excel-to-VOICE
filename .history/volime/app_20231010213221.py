# app.py
from flask import Flask, request, send_file
import openpyxl
from voicevox_engine import run

app = Flask(__name__)

engine = run()

@app.route('/upload', methods=['POST'])
def upload_file():
    file = request.files['file']
    if file:
        # Excelファイルを処理し、wavファイルを生成するロジック
        # ...
        return send_file(wav_file_path, as_attachment=True)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
