FROM public.ecr.aws/docker/library/tomcat:9.0.97-jdk8-corretto

# Remove any existing ROOT folder in the Tomcat webapps directory (to avoid conflicts)
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the compiled WAR file into the webapps directory
COPY target/vamc-todo-app.war /usr/local/tomcat/webapps/ROOT.war

# Expose the default Tomcat port
EXPOSE 8080

# Run Tomcat using the catalina.sh script
CMD ["catalina.sh", "run"]


