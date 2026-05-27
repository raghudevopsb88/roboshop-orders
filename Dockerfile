FROM docker.io/library/maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests -B

FROM docker.io/redhat/ubi9:latest
RUN dnf install -y java-17-openjdk-headless && dnf clean all
WORKDIR /app
COPY --from=builder /app/target/orders.jar .
COPY run.sh /run.sh
RUN chmod +x /run.sh
EXPOSE 8080
ENTRYPOINT ["bash", "/run.sh"]
