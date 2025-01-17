FROM ubuntu:18.04

##  Copyright (c) 2022, DURUYAO. All rights reserved.
##
##  Licensed under the Apache License, Version 2.0 (the "License");
##  you may not use this file except in compliance with the License.
##  You may obtain a copy of the License at
##
##      http://www.apache.org/licenses/LICENSE-2.0
##
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.

RUN apt-get update
RUN apt-get upgrade -y

ENV LC_ALL="C"
ENV DEBIAN_FRONTEND="noninteractive"

## install basic tools
RUN apt-get install -y apt-utils
RUN apt-get install -y sudo
RUN apt-get install -y build-essential
RUN apt-get install -y gcc g++ clang
RUN apt-get install -y make cmake ninja-build autoconf automake
RUN apt-get install -y gdb gdbserver
RUN apt-get install -y tree
RUN apt-get install -y git subversion
RUN apt-get install -y locales locales-all
RUN apt-get install -y zip unzip gzip tar
RUN apt-get install -y vim
RUN apt-get install -y tmux
RUN apt-get install -y openssh-server rsync sshpass
RUN apt-get install -y curl wget

## expose container ports
EXPOSE 22 1234

## copy files to image
COPY conf /duck
COPY login /duck

## configure proxy
#ARG HOST_PROXY="172.17.0.1:7890"
#ARG http_proxy="http://$HOST_PROXY"
#ARG https_proxy="http://$HOST_PROXY"
#ARG ftp_proxy="http://$HOST_PROXY"
#ARG no_proxy="localhost,127.0.0.0/8,::1"

## configure vim
RUN mkdir -p /duck/.vim/autoload && curl -LSso /duck/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
RUN mkdir -p /duck/.vim/bundle && git clone https://github.com/scrooloose/nerdtree.git /duck/.vim/bundle/nerdtree
RUN cp /duck/.vimrc ~/.vimrc
RUN cp -r /duck/.vim ~/.vim

## configure tmux
RUN cp /duck/.tmux.conf ~/.tmux.conf

## configure ssh
RUN mkdir /var/run/sshd
RUN echo "root:root" | chpasswd
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config
RUN sed "s@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g" -i /etc/pam.d/sshd

## configure language
RUN locale-gen en_US.UTF-8
RUN echo "export LANG=en_US.UTF-8" >>/etc/profile
RUN echo "export LC_ALL=en_US.UTF-8" >>/etc/profile
RUN echo "export LANGUAGE=en_US.UTF-8" >>/etc/profile

## configure command prompt
RUN cat /duck/root.bashrc >>~/.bashrc

## some environment variables are missing for users other than administrator
## refer to https://stackoverflow.com/questions/34630571/docker-env-variables-not-set-while-log-via-shell
## however, the following line is invalid for environment variables which are loaded at runtime
#  RUN env | grep -E -v "^(HOME=|USER=|MAIL=|LC_ALL=|LS_COLORS=|LANG=|HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_=|PS1=)" >>/etc/environment
## TODO: manually add missing environment variables, below is an example:
#  RUN echo "export LD_LIBRARY_PATH=\"/usr/local/envs/mc/lib\"" >>/duck/user.bashrc
#  RUN echo "export PATH=\"/usr/local/envs/mc/bin:/usr/local/condabin:/usr/local/nvidia/bin:/usr/local/cuda/bin:\$PATH\"" >>/duck/user.bashrc

########################################################
# add custom packages and development environment here #
########################################################
