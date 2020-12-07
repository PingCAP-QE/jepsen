all: docker-compose.yml

start:
	docker-compose up -d

clean:
	docker-compose down
	sudo rm -rf data-*

docker-compose.yml: docker-compose.jsonnet ssh-key
	jsonnet -o $@ -S $<

ssh-key:
	ssh-keygen -b 2048 -t rsa -m pem -f $@ -q -N ''

.PHONY: all start clean
