FROM centos:centos7.9.2009
WORKDIR /usr/src/elasticsearch
RUN yum -y install wget sudo perl-Digest-SHA && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-8.3.2-linux-x86_64.tar.gz && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-8.3.2-linux-x86_64.tar.gz.sha512 && shasum -a 512 -c elasticsearch-oss-8.3.2-linux-x86_64.tar.gz.sha512 && tar -xzf elasticsearch-oss-8.3.2-linux-x86_64.tar.gz
RUN /bin/sh -c 'mkdir /var/lib/elasticsearch && mkdir /var/lib/elasticsearch/logs && mkdir /var/lib/elasticsearch/data && useradd -s /sbin/nologin elastic'
RUN /bin/sh -c 'rm -f /usr/src/elasticsearch/elasticsearch-8.3.2/config/elasticsearch.yml'
COPY ./elasticsearch.yml /usr/src/elasticsearch/elasticsearch-8.3.2/config
RUN /bin/sh -c 'chown -R elastic /usr/src/elasticsearch/elasticsearch-8.3.2 && chown -R elastic /var/lib/elasticsearch'
EXPOSE 9200
EXPOSE 9300
ENTRYPOINT sudo -u elastic /usr/src/elasticsearch/elasticsearch-8.3.2/bin/elasticsearch
