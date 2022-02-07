## Starting from Ubuntu
FROM ubuntu

## Create a Non-Root User
RUN apt-get update && apt-get -y install sudo && apt-get install wget -y && apt-get install curl -y
RUN useradd -m developer && echo "developer:developer" | chpasswd && adduser developer sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

## Switch to Non-Root User
USER developer
WORKDIR /home/developer/

## Install Node
RUN sudo curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
RUN sudo bash nodesource_setup.sh
RUN sudo apt install nodejs -y

## Install Git
RUN sudo apt install git -y
ARG gitusername
ARG gitemail
ENV gitun=$gitusername
ENV gitemail=$gitemail
RUN git config --global user.name "$gitun"
RUN git config --global user.email "$gitemail"

## Install Ruby (Will install 2.7)
RUN sudo apt install ruby-full -y

## Install Python3
RUN sudo apt-get install python3 python3-dev -y

## Install Java 17
RUN sudo wget https://download.java.net/java/GA/jdk17/0d483333a00540d886896bac774ff48b/35/GPL/openjdk-17_linux-x64_bin.tar.gz
RUN sudo tar xvf openjdk-17_linux-x64_bin.tar.gz
RUN sudo mv jdk-17 /opt/
RUN echo 'JAVA_HOME=/opt/jdk-17' >> ~/.bashrc
RUN echo 'PATH=$PATH:$JAVA_HOME/bin' >> ~/.bashrc
RUN . ~/.bashrc

## Installing PHP
RUN DEBIAN_FRONTEND=noninteractive TZ="America/New York" sudo -E apt-get -y install tzdata
RUN sudo apt install -y software-properties-common
RUN sudo add-apt-repository ppa:ondrej/php
RUN sudo apt update
RUN sudo apt install php8.0 -y

## Installing Composer
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
RUN sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

## Insall Coursier
RUN curl -fL https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz | gzip -d > cs
RUN sudo chmod +x cs 
RUN ./cs setup -y
RUN ./cs install scala3
RUN ./cs install scala3-compiler
RUN echo 'PATH=$PATH:~/.local/share/coursier/bin' >> ~/.bashrc
RUN . ~/.bashrc

## Install Deno
RUN curl -fsSL https://deno.land/install.sh | sh
RUN echo 'DENO_INSTALL="/home/developer/.deno"' >> ~/.bashrc
RUN echo 'PATH="$DENO_INSTALL/bin:$PATH"' >> ~/.bashrc

## Install Nano + VIM for editing
RUN sudo apt-get install nano vim -y

## Start Container
ENTRYPOINT bash