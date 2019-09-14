
.PHONY:train
train:
	docker build -f trainer.Dockerfile -t train .
	docker run -p 8888:8888 -v models:/home/appuser/models train

.PHONY:api
api:
	docker build -f api.Dockerfile -t api .
	docker run -p 4002:5000 -v models:/home/appuser/models:ro api 

.PHONY:test
test:
	echo "AA"

