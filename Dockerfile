# FROM node:20 as nodejs
# FROM jenkins/jenkins:lts
# COPY --from=nodejs /usr/local/bin/node /usr/local/bin/node
# USER root
# RUN apt-get update && apt-get install -y curl unzip

# # Install the AWS CLI
# RUN curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
#     unzip awscliv2.zip && \
#     ./aws/install && \
#     rm -rf aws awscliv2.zip

# # Install Node.js and Angular CLI
# RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
#     apt-get install -y nodejs && \
#     npm install -g @angular/cli

# USER jenkins

# # Command to run
# # docker run -d -p 8080:8080 -p 50000:50000 --restart=on-failure jenkins

FROM node:20 as nodejs
FROM jenkins/jenkins:lts

USER root

RUN apt-get update && \
    apt-get install -y curl unzip

# Install the AWS CLI
RUN curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

# Install Node.js and Angular CLI
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g @angular/cli

# Install Docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    rm get-docker.sh

# Add the jenkins user to the docker group
RUN usermod -aG docker jenkins

USER jenkins
