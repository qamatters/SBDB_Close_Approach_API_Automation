FROM maven:3.6-jdk-8-alpine

#coping src of your framework
COPY src /home/KarateDemoFromGit/src
#coping pom file of your framework
COPY pom.xml /home/KarateDemoFromGit
#running actual command
RUN mvn -f /home/KarateDemoFromGit/pom.xml clean test -DskipTests=true
COPY /home/KarateDemoFromGit/target/karate-reports/ /Users/deepakmathpal/IdeaProjects/KarateDemoFromGit/Reports/ContainerResults/