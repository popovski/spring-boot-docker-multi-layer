SPring Boot Docker Multi Layer example

Make any changes into the Java code and execute the following commands
1. "./mvnw clean package"
    - Create the jar file
2. "docker build -t popovskinikola/spring-boot-multi-layer:1 ."
    - this command should be executed in the root of the folder of the project
    - this will read the docker file and create an image
    - also on this location we should have the docker file 
3. "docker run -p 8080:7070 popovskinikola/spring-boot-multi-layer:1"
    - This will create container in our local docker
4. http://localhost:8080/
    - Result Hello Docker Fat Jar without Layers
5. "docker push popovskinikola/spring-boot-multi-layer:1"
	- push your the repo into docker
