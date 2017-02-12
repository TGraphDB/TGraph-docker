FROM daocloud.io/songjinghe/neo4j-temporal-runtime-env:latest

MAINTAINER Jinghe Song <songjh@act.buaa.edu.cn>

EXPOSE 7474
RUN mkdir -p /tgraph

## build TGraph temporal storage
WORKDIR /tgraph
RUN git clone --depth=1 https://github.com/TGraphDB/temporal-storage.git -b recoveryFromLog --single-branch
WORKDIR /tgraph/temporal-storage
RUN mvn -B install -Dmaven.skip.test=true

## build TGraph temporal index
WORKDIR /tgraph
RUN git clone --depth=1 https://github.com/TGraphDB/temporal-index.git -b master  --single-branch
WORKDIR /tgraph/temporal-index
RUN mvn -B install -Dmaven.skip.test=true

## build TGraph temporal neo4j
WORKDIR /tgraph
RUN git clone --depth=1 https://github.com/TGraphDB/temporal-neo4j.git -b recoveryFromLog --single-branch
WORKDIR /tgraph/temporal-neo4j
RUN mvn -B install -DskipTests -Dlicense.skip=true -Dlicensing.skip

## run TGraph 
WORKDIR /tgraph/temporal-neo4j/community/server
CMD ['mvn', 'clean', 'compile', 'exec:java']
