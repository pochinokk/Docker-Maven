FROM maven:3.6.3-jdk-11 AS build

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN mvn clean package

FROM tomcat:9-jdk11
COPY --from=build /usr/src/app/target/*.war /usr/local/tomcat/webapps/


EXPOSE 8080
