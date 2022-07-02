# puxa a imagem oficial do jenkins
FROM jenkins/jenkins:lts-jdk11
# copia a pasta de configuracao do awscli
COPY .aws /var/jenkins_home/.aws
# instala os pacotes complementares
USER root
RUN apt-get update 
RUN apt-get upgrade -y && apt-get install -y \ 
net-tools build-essential bash-completion awscli \ 
ca-certificates curl gnupg lsb-release
# cria o diretorio e chaves GPG do docker
RUN mkdir -p /etc/apt/keyrings && \ 
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# cria a lista de repositorio docker no sistema
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
# instala o docker no sistema
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
# adiciona o usuario jenkins no grupo docker
RUN usermod -aG docker jenkins
# configura ps servicos do docker para iniciar automaticamente na inicializacao
RUN systemctl enable docker.service && systemctl enable containerd.service 
USER jenkins

