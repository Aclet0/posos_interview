
.PHONY:learn
learn:
	docker build -f trainer.Dockerfile -t train .
	docker run -p 8888:8888 -v ~/models:/appuser/models train

.PHONY:learn
	docker build -f api.Dockerfile -t api
	docker run -p 5000:5000 -v ~/models:/appuser/models:ro api 

.PHONY:test
test:
	echo "AA"

