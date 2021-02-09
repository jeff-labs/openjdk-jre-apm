help:
	@echo 'Help'

.DEFAULT_GOAL := help

clean:
	rm -f elastic-apm-agent.jar

download: clean
	@echo 'Download APM version'
	wget -c "https://search.maven.org/remotecontent?filepath=co/elastic/apm/elastic-apm-agent/1.20.0/elastic-apm-agent-1.20.0.jar" -o elastic-apm-agent-1.20.0.jar

build: download
	@echo 'Build docker images'
	docker build --pull --no-cache --rm -t 'mrjeffapp/openjdk-jre-apm:latest' -f Dockerfile . --build-arg BASE_IMAGE="openjdk:11-jre-slim" --build-arg APM_VERSION="1.20.0"
	docker tag 'mrjeffapp/openjdk-jre-apm:latest' 'mrjeffapp/openjdk-jre-apm:11'
	docker tag 'mrjeffapp/openjdk-jre-apm:latest' 'mrjeffapp/openjdk-jre-apm:11-1.20.0'

	docker build --pull --no-cache --rm -t 'mrjeffapp/openjdk-jre-apm:8' -f Dockerfile . --build-arg BASE_IMAGE="openjdk:8-jre-slim" --build-arg APM_VERSION="1.20.0"
	docker tag 'mrjeffapp/openjdk-jre-apm:8' 'mrjeffapp/openjdk-jre-apm:8-1.20.0'

	docker build --pull --no-cache --rm -t 'mrjeffapp/openjdk-jre-apm:10' -f Dockerfile . --build-arg BASE_IMAGE="openjdk:10-jre-slim" --build-arg APM_VERSION="1.20.0"
	docker tag 'mrjeffapp/openjdk-jre-apm:10' 'mrjeffapp/openjdk-jre-apm:10-1.20.0'

push: build
	@echo 'Push images'
	docker push 'mrjeffapp/openjdk-jre-apm:latest'
	docker push 'mrjeffapp/openjdk-jre-apm:11'
	docker push 'mrjeffapp/openjdk-jre-apm:11-1.20.0'

	docker push 'mrjeffapp/openjdk-jre-apm:8'
	docker push 'mrjeffapp/openjdk-jre-apm:8-1.20.0'

	docker push 'mrjeffapp/openjdk-jre-apm:10'
	docker push 'mrjeffapp/openjdk-jre-apm:10-1.20.0'
