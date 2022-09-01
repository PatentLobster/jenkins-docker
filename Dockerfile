FROM jenkins/jenkins
USER root
RUN apt-get -y update 
RUN apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common 
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor >> /usr/share/keyrings/ubuntu.gpg 
RUN add-apt-repository \
 "deb [signed-by=/usr/share/keyrings/ubuntu.gpg arch=amd64] https://download.docker.com/linux/$( ./etc/os-release;echo "$ID") \
 $(lsb_release -cs) \
 stable" 
RUN apt-get update 
RUN apt-get -y install docker-ce docker-ce-cli containerd.io
RUN curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose 
RUN chmod +x /usr/local/bin/docker-compose 
RUN ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
USER jenkins
