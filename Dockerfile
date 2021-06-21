FROM tomcat:8-jdk11

ADD ./webapp/target/*.war $CATALINA_BASE/webapps/

EXPOSE 8080

CMD [ "catalina.sh", "run" ]
