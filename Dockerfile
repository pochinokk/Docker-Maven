FROM openjdk:11

COPY ./target/my-project.jar /app/my-project.jar

CMD ["java", "-jar", "/app/my-project.jar"]