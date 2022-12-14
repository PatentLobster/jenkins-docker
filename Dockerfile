FROM jenkins/jenkins


ARG HOST_UID=1000
ARG HOST_GID=281

USER root
RUN apt-get -y update 
RUN apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common 
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor >> /etc/apt/trusted.gpg.d/ubuntu.gpg 
RUN add-apt-repository \
 "deb [arch=amd64,signed-by=/etc/apt/trusted.gpg.d/ubuntu.gpg] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
RUN apt-get update 
RUN apt-get -y install docker-ce docker-ce-cli containerd.io
RUN curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose 
RUN chmod +x /usr/local/bin/docker-compose 
RUN ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

RUN usermod -u $HOST_UID jenkins
RUN groupmod -g $HOST_GID docker
RUN usermod -aG docker jenkins

USER jenkins
