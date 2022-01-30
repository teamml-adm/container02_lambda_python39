# Lambda コンテナ
# base aws/lambda/Python3.9 + Google Cloud SDK
FROM public.ecr.aws/lambda/python:3.9
LABEL maintainer="mshinoda <shinoda@data-artist.com>"

# install basic commands
RUN yum install -y curl telnet jq vim zip unzip nkf less diff tar wget

# install Google Cloud SDK
# https://cloud.google.com/sdk/docs/quickstart-redhat-centos?hl=ja
COPY google-cloud-sdk.repo /etc/yum.repos.d/google-cloud-sdk.repo
RUN yum install -y google-cloud-sdk

# 実行クラス群＋Pythonライブラリ定義の転送
COPY app ${LAMBDA_TASK_ROOT}
COPY requirements.txt ${LAMBDA_TASK_ROOT}

# Pythonライブラリの導入
RUN pip3 install -r requirements.txt

# hander function
CMD [ "main.handler" ]
