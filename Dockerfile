FROM openjdk:8-jdk-alpine

RUN apk add --no-cache curl tar bash
ENV MAVEN_VERSION 3.8.4
RUN mkdir -p /usr/share/maven \
    && curl -fsSL https://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -xzC /usr/share/maven --strip-components=1 \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

WORKDIR /app

COPY . .

CMD ["mvn", "clean", "install"]
