This project uses Karate Framework to demonstrate the API Automation.
Karate is an open-source tool to combine API test-automation, mocks, performance-testing and even UI automation into a single, unified framework. 
The BDD syntax popularized by Cucumber is language-neutral, and easy 
for even non-programmers. Assertions and HTML reports are built-in, 
and you can run tests in parallel for speed.

Please visit this link to know about the framework:
https://github.com/karatelabs/karate

**To start the project**, please take a clone of this project from github or 
follow the steps mentioned in below link:
https://testwithease.blogspot.com/2021/04/karate-framework-how-to-setup-project.html

Once the project is cloned, Under the regression folder, create your Test suite for
the project api's. To know more about,how to write automation test cases with framework,you
can follow this blog:
https://testwithease.blogspot.com/2020/07/api-automation-with-karate-framework.html

**Project Structure:**

-> **POM.xml** : It contains all the relvent dependecies for the project.

-> **test->java->apiTest->Regression** -> This folder is to hold your scenarios.
You are free to change the directory name as per your wish.

-> **karate-config fil**e: This file keeps the config related information.
We can keep the URL, apitoken, connectionTimeout, connectionResetTimeout
information here. 

**DockerFile**: This file keeps the commands which will help you to run the suite
inside a docker container.

**Once your automated test is ready, you can run it:** 
1. By just right clicking on the feature file, and click on run (If project is configured in any IDE like Intelij)
2. You can run the cucumberReport.java file (Make sure the tag is appropriate
   in the cucumber report file)
3. or you can run it with the help of mvn command

**How to run Test suite inside docker container:**
1. Create a docker image : docker build -t apiautomationdemo .
2. Once the docker image is created, run the test cases with below command:
   docker run -d --network="host" apiautomationdemo  mvn -f /home/SBDB_Close_Approach_API_Automation/pom.xml clean test -DargLine='-Dkarate.env=e2e' -Dkarate.options="--tags @Smoke" -Dtest=CucumberReport -DfailIfNoTests=false
3. To check logs, you can run :
docker logs "<your docker image id>"
4. Once the execution is complete, you will see something like this in logs: 

(In te docker run command, you can change the tag from smoke,Regression, healtchCheck etc, Pre -requisite is, these tags should
be present inside your feature file.)

**Generating summary**

**Total Scenarios** :2

**Total Pass Scenarios** :2

**Total Fail Scenarios** :0

[INFO] **Tests run:** 1**, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 38.077 s - in apiTest.CucumberReport**

[INFO]

[INFO] Results:

[INFO]

[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0

[INFO]

[INFO] ------------------------------------------------------------------------

[INFO] **BUILD SUCCESS**

[INFO] ------------------------------------------------------------------------

[INFO] Total time:  01:19 min

[INFO] Finished at: 2022-09-26T09:25:07Z

[INFO] ------------------------------------------------------------------------

**View Report:**   
Karate framework generates report inside Target folder. But to keep history
of reports, we pick those reports to  new folder "Reports" inside the 
project. So to view report,please run below docker command:

docker cp <yor docker image id>:/home/SBDB_Close_Approach_API_Automation/Reports/ /Users/<enter username>/IdeaProjects/SBDB_Close_Approach_API_Automation/Reports/

(The above command is copying results from docker image reports folder to your local reports folder. It might be that, you will have to change your local folder path here)
