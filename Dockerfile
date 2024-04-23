FROM openjdk:11
ENV MAVEN_HOME /usr/share/maven
RUN apt-get update && \
    apt-get install -y maven && \
    rm -rf /var/lib/apt/lists/*
COPY ./ /app
WORKDIR /app
RUN mvn clean package
CMD ["java", "-jar", "target/my-app.jar"]