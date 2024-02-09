FROM maven:3.6.0-jdk-8 as builder
WORKDIR /app
COPY . /app
RUN mvn clean package -Dmaven.repo.local=.m2

FROM openjdk:8-jre
COPY --from=builder /app/target /etc/monitoring
RUN mv /etc/monitoring/*.jar /etc/monitoring/server.jar
CMD ["java", "-jar", "/etc/monitoring/server.jar"]
