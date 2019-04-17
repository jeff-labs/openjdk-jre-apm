# OpenJDK with Elastic APM java agent
Mr Jeff's OpenJDK docker image with Elastic APM java agent.

![docker pulls](https://img.shields.io/docker/pulls/mrjeffapp/openjdk-jre-apm.svg?style=plastic)
![docker stars](https://img.shields.io/docker/stars/mrjeffapp/openjdk-jre-apm.svg?style=flat)

[Elastic APM java agent reference](https://www.elastic.co/guide/en/apm/agent/java/current/index.html)

## How to use the docker image
Extend your image from our image. 
```Dockerfile
FROM mrjeffapp/openjdk-jre-apm:11-1.6.0

ENV JAVA_OPTS=""

CMD exec java -Djava.security.egd=file:/dev/./urandom -jar -javaagent:elastic-apm-agent.jar $JAVA_OPTS micro-service.jar
````

## How to build a new image
1. Change the gradle properties to set a new Java version or Elastic APM version.
```gradle
ext {
    javaVersion = "11"
    apmVersion = "1.6.0"
}
```
2. Download Elastic APM.

```bash
./gradlew download

```

3. Build docker image.

```bash
./gradlew docker

```

4. Tag the built image.

```bash
./gradlew dockerTag

```

5. Push the tagged image to dockerhub.

```bash
./gradlew dockerPush

```
