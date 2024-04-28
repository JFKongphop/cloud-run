IMAGE_NAME := myapp

dev:
	nodemon --exec go run main.go --signal SIGTERM

dcb:
	docker build -t ${IMAGE_NAME} .

dcr:
	docker run --name ${IMAGE_NAME} -p 1323 -d ${IMAGE_NAME}

start:
	docker build -t ${IMAGE_NAME} . && docker run --name ${IMAGE_NAME} -p 1323:8000 -d ${IMAGE_NAME}

rmi:
	docker stop ${IMAGE_NAME} && docker rm ${IMAGE_NAME} && docker rmi ${IMAGE_NAME}

dt:
	curl http://localhost:1323/test | jq

at:
	curl http://localhost:8000/test | jq