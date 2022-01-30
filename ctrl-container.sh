#!/bin/bash
# コンテナ操作スクリプト
IMAGE_NAME=twitter-base-stats
TAG=latest
DOMAIN=112233445566.dkr.ecr.ap-northeast-1.amazonaws.com
URL_REPO=${DOMAIN}/${IMAGE_NAME}

# コンテナのビルド
build() {
  docker build -t ${IMAGE_NAME} .
}

# コンテナをECRにプッシュ
push() {
  # 1. login
  aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin ${DOMAIN} 

  # 2. tagging
  echo docker tag ${IMAGE_NAME}:${TAG} ${URL_REPO}:${TAG}
  docker tag ${IMAGE_NAME}:${TAG} ${URL_REPO}:${TAG}

  # 3. register to ECR
  echo docker push ${URL_REPO}:${TAG}
  docker push ${URL_REPO}:${TAG}
}

# コンテナの停止
stop() {
  echo "--- stopping container  ---"
  container_id=`docker ps|grep -v IMAGE|cut -d " " -f1`
  echo $container_id
  if [ "${container_id}" != "" ]; then 
      docker stop ${container_id}
  fi
  echo ""
}

# コンテナの起動
start() {
  echo "--- starting container  ---"
  docker run -d --env-file env.txt --rm -p 9000:8080 ${IMAGE_NAME}
  echo ""
}

# コンテナの状態確認
status() {
  echo "--- check container status  ---"
  docker ps
  echo ""
}

# コンテナの中に入る
login() {
  echo "--- start container  ---"
  container_id=`docker ps|grep -v IMAGE|cut -d " " -f1`
  echo "container:${container_id}"
  if [ "${container_id}" == "" ]; then
      start
      sleep 1
      container_id=`docker ps|grep -v IMAGE|cut -d " " -f1`
  fi
  docker exec -it ${container_id} bash
}

# ローカル挙動確認
test() {
    curl -d '{}' http://localhost:9000/2015-03-31/functions/function/invocations
}

case $1 in
start)
  stop
  start
  status
  ;;
stop)
  stop
  status
  ;;
status)
  status
  ;;
restart)
  stop
  start
  status
  ;;
build)
  build
  ;;
push)
  push
  ;;
login)
  login
  ;;
test)
  test;;
*)
  echo "Usage: 0 [start|stop|status|restart|loign|build|push|test]"
  ;;
esac
exit 0
