FROM daocloud.io/songjinghe/neo4j-temporal-runtime-env:latest
MAINTAINER Jinghe Song <songjh@act.buaa.edu.cn>

EXPOSE 7474
RUN mkdir -p /opt/neo4j
WORKDIR /opt/neo4j

RUN git clone --depth=1 https://github.com/neo4j/neo4j.git -b 3.2 --single-branch
WORKDIR /opt/neo4j/neo4j
RUN mvn -B install -DskipTests -Dlicense.skip=true -Dlicensing.skip
# RUN mvn -B install -DminimalBuild -Dlicense.skip=true -Dlicensing.skip
WORKDIR /opt/neo4j/neo4j/community/server
CMD ['mvn', 'clean', 'compile', 'exec:java']
