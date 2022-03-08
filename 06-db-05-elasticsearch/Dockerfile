FROM centos:7
RUN yum -y update && \
    yum -y install wget && \
    yum -y install perl-Digest-SHA &&  \
    yum -y install less && \
    yum -y install vim-enhanced && \
    yum -y clean all && \
    rm -rf /var/cache &&  \
    wget https://download.java.net/java/GA/jdk17/0d483333a00540d886896bac774ff48b/35/GPL/openjdk-17_linux-x64_bin.tar.gz && \
    tar xvf openjdk-17_linux-x64_bin.tar.gz && \
    rm -f openjdk-17_linux-x64_bin.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.0.1-darwin-x86_64.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.0.1-darwin-x86_64.tar.gz.sha512 && \
    shasum -a 512 -c elasticsearch-8.0.1-darwin-x86_64.tar.gz.sha512 && \
    tar -xzf elasticsearch-8.0.1-darwin-x86_64.tar.gz && \
    rm -f elasticsearch-8.0.1-darwin-x86_64.tar.gz && \
    rm -f elasticsearch-8.0.1-darwin-x86_64.tar.gz.sha512 && \
    groupadd elasticsearch && \
    useradd elasticsearch -g elasticsearch -p elasticsearch && \
    mkdir /var/lib/elasticsearch && \
    chown elasticsearch:elasticsearch -R elasticsearch-8.0.1 && \
    chown elasticsearch:elasticsearch -R /var/lib/elasticsearch && \
    echo 'cluster.name: netology_claster' >> /elasticsearch-8.0.1/config/elasticsearch.yml && \
    echo 'node.name: netology_test' >> /elasticsearch-8.0.1/config/elasticsearch.yml && \
    echo 'path.data: /var/lib/elasticsearch' >> /elasticsearch-8.0.1/config/elasticsearch.yml && \
    echo 'xpack.ml.enabled: false' >> /elasticsearch-8.0.1/config/elasticsearch.yml;
ENV JAVA_HOME /jdk-17
ENV ES_JAVA_HOME /jdk-17
VOLUME [ "./test_data" ]
ENTRYPOINT runuser -u elasticsearch -- /elasticsearch-8.0.1/bin/elasticsearch