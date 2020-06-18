FROM openjdk:8-jdk-alpine

COPY target/*-fat.jar app.jar

ENTRYPOINT ["java","-jar","app.jar"]
