FROM openjdk:11-jre as builder

# set the working directory
WORKDIR application

# copy the jar file
ARG ARTIFACT_NAME=target/*.jar
COPY ${ARTIFACT_NAME} app.jar

RUN java -Djarmode=layertools -jar app.jar extract

FROM adoptopenjdk:11-jre-hotspot

ARG EXPOSED_PORT
EXPOSE ${EXPOSED_PORT}

ENV SPRING_PROFILES_ACTIVE docker
# we are extracting the jar file so docker can build layers

# every copy command is creating new layer in the image, this can be reviewed using the docker history
# if in some of this layers have change some file then docker will know that
# based on the layers.idx file in the jar file we are doing copy paste
COPY --from=builder application/dependencies/ ./
COPY --from=builder application/spring-boot-loader/ ./
COPY --from=builder application/snapshot-dependencies/ ./
COPY --from=builder application/application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]