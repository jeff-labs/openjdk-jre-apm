FROM openjdk:10-jre-slim

ENV APM_VERSION="1.3.0"

RUN curl https://search.maven.org/remotecontent?filepath=co/elastic/apm/elastic-apm-agent/${APM_VERSION}/elastic-apm-agent-${APM_VERSION}.jar --output elastic-apm-agent.jar

RUN ls
