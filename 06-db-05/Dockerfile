FROM centos:centos7.9.2009
WORKDIR /usr/src/elasticsearch
COPY ./elasticsearch-8.2.2-linux-x86_64.tar.gz /usr/src/elasticsearch/elasticsearch-8.2.2-linux-x86_64.tar.gz
RUN yum -y install sudo && tar -xzf elasticsearch-8.2.2-linux-x86_64.tar.gz
RUN /bin/sh -c 'mkdir /var/lib/elasticsearch && mkdir /var/lib/elasticsearch/data && useradd -s /sbin/nologin elastic'
RUN /bin/sh -c 'rm -f /usr/src/elasticsearch/elasticsearch-8.2.2/config/elasticsearch.yml'
COPY ./elasticsearch.yml /usr/src/elasticsearch/elasticsearch-8.2.2/config
RUN /bin/sh -c 'chown -R elastic /usr/src/elasticsearch/elasticsearch-8.2.2 && chown -R elastic /var/lib/elasticsearch'
EXPOSE 9200
EXPOSE 9300
ENTRYPOINT sudo -u elastic /usr/src/elasticsearch/elasticsearch-8.2.2/bin/elasticsearch