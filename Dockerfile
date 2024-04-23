FROM maven:3.8.4-openjdk-11 AS builder

COPY ./ /app

WORKDIR /app

RUN mvn clean package

FROM openjdk:11

COPY --from=builder /app/target/my-project-jar-with-dependencies.jar /app/my-project.jar

CMD ["java", "-jar", "/app/my-project.jar"]
