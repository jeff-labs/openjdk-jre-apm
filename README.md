# OpenJDK with Elastic APM
MrJeff OpenJDK with Elastic APM docker image

![docker pulls](https://img.shields.io/docker/pulls/mrjeffapp/openjdk-jre-apm.svg?style=plastic)
![docker stars](https://img.shields.io/docker/stars/mrjeffapp/openjdk-jre-apm.svg?style=flat)

## How to use the docker image
Extend your image from our image. 
```Dockerfile
FROM mrjeffapp/openjdk-jre-apm:10

ENV JAVA_OPTS=""

CMD exec java -Djava.security.egd=file:/dev/./urandom -jar -javaagent:elastic-apm-agent.jar $JAVA_OPTS micro-service.jar
````

## How to build a new image
1. Change the gradle properties to set a new Java version or Elastic APM version.
```gradle
ext {
    javaVersion = "10"
    apmVersion = "1.4.0"
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
