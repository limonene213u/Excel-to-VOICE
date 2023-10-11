FROM python:3.11

# OSのパッケージをアップデート
RUN apt-get update && apt-get upgrade -y

# treeなどをインストール
RUN apt-get install -y tree pkg-config libmariadb-dev-compat libmariadb-dev libmariadb3
RUN apt-get update && apt-get install -y wget unzip


# Node.jsとnpmをインストール（機能拡張などで必要であれば）
#RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
#RUN apt-get install -y nodejs

# ディレクトリを作成する
RUN mkdir -p /app/pdfjs

# Pythonの依存関係をインストール
RUN pip install --upgrade pip
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# requestsモジュールのインストール
RUN pip install requests

# ディレクトリ構造を作成
WORKDIR /app
RUN mkdir static static/css static/js templates uploaded_files

# ポート5000を公開
EXPOSE 5000

CMD ["python", "app.py"]
