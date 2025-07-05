FROM public.ecr.aws/docker/library/tomcat:9.0.97-jdk8-corretto

# Remove existing ROOT app to avoid conflicts
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your compiled WAR file into Tomcat
COPY target/vamc-todo-app.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat default port
EXPOSE 8080

# Correct CMD instruction
CMD ["catalina.sh", "run"]
