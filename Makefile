.DEFAULT_GOAL := help

apm_version = 1.20.0

help:
	@echo 'Run make build'
	@echo "APM version: ${apm_version}"

clean:
	rm -f elastic-apm-agent-*.jar

download: clean
	@echo "Download APM version: ${apm_version}"
	wget -c "https://repo1.maven.org/maven2/co/elastic/apm/elastic-apm-agent/${apm_version}/elastic-apm-agent-${apm_version}.jar"

build: download
	@echo 'Build docker images'
	docker build --pull --no-cache --rm -t 'mrjeffapp/openjdk-jre-apm:11-${apm_version}' -f Dockerfile . --build-arg BASE_IMAGE="openjdk:11-jre-slim" --build-arg APM_VERSION="${apm_version}"
	docker tag 'mrjeffapp/openjdk-jre-apm:11-${apm_version}' 'mrjeffapp/openjdk-jre-apm:11'
	docker tag 'mrjeffapp/openjdk-jre-apm:11-${apm_version}' 'mrjeffapp/openjdk-jre-apm:latest'

	docker build --pull --no-cache --rm -t 'mrjeffapp/openjdk-jre-apm:8-${apm_version}' -f Dockerfile . --build-arg BASE_IMAGE="openjdk:8-jre-slim" --build-arg APM_VERSION="${apm_version}"
	docker tag 'mrjeffapp/openjdk-jre-apm:8-${apm_version}' 'mrjeffapp/openjdk-jre-apm:8'

	docker build --pull --no-cache --rm -t 'mrjeffapp/openjdk-jre-apm:10-${apm_version}' -f Dockerfile . --build-arg BASE_IMAGE="openjdk:10-jre-slim" --build-arg APM_VERSION="${apm_version}"
	docker tag 'mrjeffapp/openjdk-jre-apm:10-${apm_version}' 'mrjeffapp/openjdk-jre-apm:10'


test:
	@echo 'Test images'
	docker run mrjeffapp/openjdk-jre-apm:11-${apm_version} java -javaagent:elastic-apm-agent.jar -version
	docker run mrjeffapp/openjdk-jre-apm:10-${apm_version} java -javaagent:elastic-apm-agent.jar -version
	docker run mrjeffapp/openjdk-jre-apm:8-${apm_version} java -javaagent:elastic-apm-agent.jar -version

push:
	@echo 'Push images'
	docker push 'mrjeffapp/openjdk-jre-apm:11-${apm_version}'
	docker push 'mrjeffapp/openjdk-jre-apm:11'
	docker push 'mrjeffapp/openjdk-jre-apm:latest'


	docker push 'mrjeffapp/openjdk-jre-apm:8-${apm_version}'
	docker push 'mrjeffapp/openjdk-jre-apm:8'

	docker push 'mrjeffapp/openjdk-jre-apm:10-${apm_version}'
	docker push 'mrjeffapp/openjdk-jre-apm:10'
