FROM openjdk:17-oracle

ENV SPRING_PROFILES_ACTIVE cloud

COPY target/eureka-server-0.0.1-SNAPSHOT.jar eurekaserver-service.jar 


ENTRYPOINT [ "java", "-Dspring.profiles.active=${SPRING_PROFILES_ACTIVE}","-jar","eurekaserver-service.jar" ]

#	java -Dspring.profiles.active=dev -jar <jar-Name>

