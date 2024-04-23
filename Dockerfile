FROM maven:3.8.4-openjdk-17-slim
COPY . /app
WORKDIR /app
RUN mvn clean install
CMD ["java", "-jar", "target/your-application.jar"]