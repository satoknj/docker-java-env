FROM ubuntu:14.04
MAINTAINER satk0909 "gk0909c@gmail.com"

# install
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-get install -y dbus dbus-x11 && \
    apt-get install -y curl wget git && \
    apt-get install -y libgtk2.0 libxtst6 --no-install-recommends && \
    apt-get install -y ssh && \
    service ssh start

# add User
RUN useradd -d /home/dev -s /bin/bash -m dev && echo "dev:dev" | chpasswd && \
    #echo "dev:x:1000:1000:Dev,,,:/home/dev:/bin/bash" >> /etc/passwd && \
    #echo "dev:x:1000:" >> /etc/group && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/dev && \
    chmod 0440 /etc/sudoers.d/dev && \
    chown dev:dev -R /home/dev

# install JDK
RUN wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.tar.gz && \
    tar zxvf jdk-8u60-linux-x64.tar.gz && \
    mv jdk1.8.0_60 /usr/local/ && \
    ln -s /usr/local/jdk1.8.0_60/bin/java /usr/bin/java && \
    ln -s /usr/local/jdk1.8.0_60/bin/javac /usr/bin/javac && \
    rm jdk-8u60-linux-x64.tar.gz

# install Eclipse
RUN wget http://developer.eclipsesource.com/technology/epp/mars/eclipse-jee-mars-1-linux-gtk-x86_64.tar.gz && \
    tar -zxf eclipse-jee-mars-1-linux-gtk-x86_64.tar.gz eclipse && \
    mv eclipse /home/dev && \
    chmod 111 /home/dev/eclipse/eclipse && \
    chown dev:dev -R /home/dev/eclipse && \
    rm eclipse-jee-mars-1-linux-gtk-x86_64.tar.gz 

# install Tomcat
RUN wget http://ftp.yz.yamagata-u.ac.jp/pub/network/apache/tomcat/tomcat-8/v8.0.28/bin/apache-tomcat-8.0.28.tar.gz && \
    tar zxf apache-tomcat-8.0.28.tar.gz && \
    mv apache-tomcat-8.0.28 /opt/tomcat8 && \
    rm apache-tomcat-8.0.28.tar.gz && \
    chown dev:dev -R /opt/tomcat8

# install ubuntu-desktop
RUN add-apt-repository -y ppa:gnome3-team/gnome3 && \
    apt-get update && \
    apt-get -y install gnome-shell --no-install-recommends && \
    apt-get -y install ubuntu-desktop --no-install-recommends && \
    apt-get -y install fonts-ipafont && \
    apt-get -y install fcitx-mozc

# ポート解放
EXPOSE 22 8080

USER dev
ENV HOME /home/dev
WORKDIR /home/dev

RUN echo "fcitx -r" >> ~/.bashrc && \
    echo "export DISPLAY=localhost:10.0" >> ~/.bashrc && \
    echo "xset -r 49" >> ~/.bashrc

USER root
CMD /usr/sbin/sshd -D

