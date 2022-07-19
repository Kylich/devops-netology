FROM centos:centos7.9.2009
COPY elasticsearch-8.2.2-linux-x86_64.tar.gz .
RUN yum install -y java-11-openjdk wget curl perl-Digest-SHA
RUN export ES_HOME="/var/lib/elasticsearch" && \
    tar -xzf elasticsearch-8.2.2-linux-x86_64.tar.gz && \
    rm -f elasticsearch-8.2.2-linux-x86_64.tar.gz && \
    mv elasticsearch-8.2.2 ${ES_HOME} && \
    useradd -m -u 1000 elasticsearch && \
    chown elasticsearch:elasticsearch -R ${ES_HOME}
COPY --chown=elasticsearch:elasticsearch config/* /var/lib/elasticsearch/config/
USER 1000
WORKDIR /var/lib/elasticsearch/
EXPOSE 9200 9300
ENTRYPOINT ["bin/elasticsearch"]