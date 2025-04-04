ARG CHROME_VERSION='131.0.6778.264-1'
ARG EDGE_VERSION=''
ARG FIREFOX_VERSION=''
ARG CYPRESS_VERSION='13.3.0'

FROM cypress/factory:4.0.2

RUN apt update && apt install -y nano curl git openssh-client inotify-tools jq make gcc g++ libc-dev less cppcheck docker.io
RUN npm install -g pnpm
RUN npm install -g yarn

WORKDIR /home

RUN mkdir -p /home/awscli && cd /home/awscli && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip && unzip awscliv2.zip && ./aws/install

RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh
COPY ./known_hosts /root/.ssh/

RUN git config --global --add safe.directory /home/work
