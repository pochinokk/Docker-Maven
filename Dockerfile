FROM openjdk:8-jdk-alpine

RUN apk add --no-cache maven

COPY src /usr/local/service/src
WORKDIR /usr/local/service
RUN mvn package

CMD ["java","-jar","target/docker-service-1.0-SNAPSHOT-jar-with-dependencies.jar"]
