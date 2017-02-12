FROM daocloud.io/songjinghe/neo4j-temporal-runtime-env:latest
MAINTAINER Jinghe Song <songjh@act.buaa.edu.cn>

RUN mkdir /tgraph
WORKDIR /tgraph

## build TGraph temporal storage
RUN git clone --depth=1 https://github.com/TGraphDB/temporal-storage.git -b recoveryFromLog --single-branch
WORKDIR /tgraph/temporal-storage
RUN mvn -B dependency:resolve

## build TGraph temporal index
RUN git clone --depth=1 https://github.com/TGraphDB/temporal-index.git -b master  --single-branch
WORKDIR /tgraph/temporal-index
RUN mvn -B dependency:resolve

## build TGraph temporal neo4j
RUN git clone --depth=1 https://github.com/TGraphDB/temporal-neo4j.git -b recoveryFromLog --single-branch
WORKDIR /tgraph/temporal-neo4j
RUN mvn -B dependency:resolve

## clean up source code
RUN rm -rf /tgraph
