FROM n3ziniuka5/ubuntu-oracle-jdk:14.04-JDK8

MAINTAINER Jinghe Song <songjh@act.buaa.edu.cn>

RUN apt-get update && apt-get install -y --no-install-recommends \
  subversion emacs23-nox wget curl \
  graphviz nodejs-legacy npm make devscripts debhelper rpm unzip git \
  debhelper devscripts dos2unix dpkg make xmlstarlet \
  && rm -rf /var/lib/apt/lists/*

ENV MAVEN_VERSION 3.3.9
RUN wget -q "https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" \
  && tar xzf "apache-maven-$MAVEN_VERSION-bin.tar.gz" -C /usr/share \
  && mv "/usr/share/apache-maven-$MAVEN_VERSION" /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
  && rm -rf "apache-maven-$MAVEN_VERSION-bin.tar.gz"
ENV MAVEN_HOME /usr/share/maven
# ADD settings.xml /usr/share/maven/conf/settings.xml
ENV MAVEN_OPTS '-Xmx512m -XX:MaxPermSize=256m'
VOLUME /root/.m2
