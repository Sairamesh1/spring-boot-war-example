FROM ubuntu:latest AS checkout
RUN apt update
RUN apt install git -y
RUN git clone https://github.com/Sairamesh1/spring-boot-war-example.git
WORKDIR /spring-boot-war-example

FROM maven:3.8.6-amazoncorretto-11 AS build
WORKDIR /app
COPY --from=checkout /spring-boot-war-example .
RUN mvn clean install

FROM artisantek/tomcat:1 AS deploy
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/
EXPOSE 9090
CMD ["catalina.sh", "run"]
