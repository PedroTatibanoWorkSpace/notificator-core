# Multi-stage build

# Etapa de build
FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /app

COPY .mvn .mvn
COPY mvnw .
COPY mvnw.cmd .
COPY pom.xml .

RUN ./mvnw dependency:go-offline -B

COPY src ./src

RUN ./mvnw clean package -DskipTests -B

# Etapa de runtime
FROM eclipse-temurin:21-jdk

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
