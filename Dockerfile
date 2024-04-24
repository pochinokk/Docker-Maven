FROM maven:3.6.3-openjdk-8-slim

COPY . /usr/local/service
WORKDIR /usr/local/service

RUN mvn package

CMD ["java", "-jar", "target/simple-server.jar"]
