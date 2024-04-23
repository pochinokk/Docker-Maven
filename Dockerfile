
FROM openjdk:latest


ENV MAVEN_VERSION=3.8.4
ENV MAVEN_HOME=/usr/share/maven
ENV MAVEN_OPTS="-Xms256m -Xmx512m"
ENV PATH=${MAVEN_HOME}/bin:${PATH}


RUN mkdir -p /usr/share/maven \
    && curl -fsSL https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | tar -xzC /usr/share/maven --strip-components=1 \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

COPY . /app

WORKDIR /app


RUN mvn clean install

CMD ["java", "-jar", "target/your-application.jar"]
