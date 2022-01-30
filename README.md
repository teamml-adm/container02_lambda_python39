# Lambda コンテナの雛形

このコンテナは Lamba コンテナを利用する際の雛形として利用可能です。

## ファイル構成

```
.
├── app                 app ディレクトリ以下が コンテナ内部にコピーされます。
│   └── main.py         hander関数を含むファイル(窓口となる関数は main.handler と設定しています)
├── ctrl-container.sh   コンテナを制御するスクリプト
├── Dockerfile          コンテナイメージを定義するファイル
├── env.txt             環境変数を設定してください。
├── google-cloud-sdk.repo  GCPを制御する場合に yum リポジトリに登録するファイル
├── README.md           このファイルです
└── requirements.txt　  インストールするPythonパッケージの定義
```

## コンテナの操作手順
ctrl-container.sh<br>
にコンテナを統一的に操作するスクリプトを準備しています。

```
コンテナをビルドする
$ bash ctrl-container.sh build

コンテナを起動する
$ bash ctrl-container.sh start

コンテナを停止する
$ bash ctrl-container.sh stop

コンテナを再起動する
$ bash ctrl-container.sh restart

コンテナ内にログインする
$ bash ctrl-container.sh login

コンテナをECRにpushする
$ bash ctrl-container.sh push

コンテナの動作確認をローカルで行う
$ bash ctrl-container.sh test

```

## Dockerfile

aws/lambda/Python3.9 をベースのコンテナとして利用し、Google Cloud SDKを同梱しています。<br>
不要であれば、コメントアウトしてください。

- コンテナのOS<br>
ベースコンテナのOSは Amazon Linux2で、yum がリポジトリ管理のコマンドになります。<br>
必要なコマンドがあれば、「install basic commands」のセクションで追加してください。

- コンテナの環境変数<br>
以下を参照のこと。<br>
https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/configuration-envvars.html

- Python のバージョンを変更したい場合<br>
以下を参考にして修正してください。<br>
https://gallery.ecr.aws/bitnami/python
