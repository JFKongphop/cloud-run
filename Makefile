IMAGE_NAME := myapp

dcb:
	docker build -t ${IMAGE_NAME} .

dcr:
	docker run --name ${IMAGE_NAME} -p 1323 -d ${IMAGE_NAME}

start:
	docker build -t ${IMAGE_NAME} . && docker run --name ${IMAGE_NAME} -p 1323:1323 -d ${IMAGE_NAME}

rmi:
	docker stop ${IMAGE_NAME} && docker rm ${IMAGE_NAME} && docker rmi ${IMAGE_NAME}