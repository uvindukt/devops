FROM openjdk:11-slim
EXPOSE 8080
ADD target/devops.jar devops.jar
ENTRYPOINT ["java","-jar","/devops.jar"]