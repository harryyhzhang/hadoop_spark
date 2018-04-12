FROM harryyhzhang/resourcemanager 
MAINTAINER Ivan Ermilov <ivan.s.ermilov@gmail.com>

ENV http_proxy "http://hzha:Th0ughtW0rkerk@caa-proxybr.co.i.caa.ca:8080"
ENV https_proxy "https://hzha:Th0ughtW0rkerk@caa-proxybr.co.i.caa.ca:8080"

RUN echo 'Acquire::http::No-Cache true;' > /etc/apt/apt.conf

RUN echo 'Acquire::http::Pipeline-Depth 0;' >> /etc/apt/apt.conf

RUN apt-get update && apt-get install -y curl wget 


RUN curl -s http://apache.mirror.colo-serv.net/spark/spark-1.6.3/spark-1.6.3-bin-hadoop2.6.tgz | tar -xz -C /usr/local/  

RUN cd /usr/local && ln -s spark-1.6.3-bin-hadoop2.6 spark

ENV SPARK_HOME /usr/local/spark
ENV HADOOP_HOME /opt/hadoop-2.7.5
ENV PATH $PATH:$SPARK_HOME/bin:$HADOOP_HOME/bin

RUN cp $SPARK_HOME/conf/spark-defaults.conf.template $SPARK_HOME/conf/spark-defaults.conf

RUN echo spark.yarn.jars hdfs:///spark/*.jar > $SPARK_HOME/conf/spark-defaults.conf

RUN wget http://repo1.maven.org/maven2/com/sun/jersey/jersey-bundle/1.19.1/jersey-bundle-1.19.1.jar -O $SPARK_HOME/jars/jersey-bundle-1.19.1.jar

RUN hadoop fs -put $SPARK_HOME/jars /spark

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

RUN apt-get update && apt-get install -y software-properties-common

RUN add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial/'

RUN apt-get install -y apt-transport-https

RUN apt-get update && apt-get install -y r-base gdebi-core

RUN wget https://download2.rstudio.org/rstudio-server-1.1.442-amd64.deb

RUN gdebi --non-interactive rstudio-server-1.1.442-amd64.deb

RUN addgroup rstudio

RUN adduser --ingroup rstudio rstudio --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password

RUN echo "rstudio:rstudio" | sudo chpasswd

RUN wget http://apache.mirror.colo-serv.net/hive/hive-2.3.3/apache-hive-2.3.3-bin.tar.gz -O /tmp/hive.tar.gz 

RUN tar xf /tmp/hive.tar.gz -C /usr/local/ && rm /tmp/hive.tar.gz

ENV HIVE_HOME /usr/local/apache-hive-2.3.3-bin  

ENV PATH $HIVE_HOME/bin:$PATH

RUN wget http://stat-computing.org/dataexpo/2009/2008.csv.bz2 	 -O flights.csv.bz2 && bunzip2 flights.csv.bz2

RUN apt-get update && apt-get install -y openjdk-8-jdk && apt-get install -y libxml2-dev

CMD echo 'Sys.setenv(https_proxy = "10.100.33.50:8080");\n\
Sys.setenv(https_proxy_user= "hzha:Th0ughtW0rkerk");\n\
Sys.setenv(http_proxy="http://10.100.33.50:8080");\n\
Sys.setenv(http_proxy_user="hzha:Th0ughtW0rkerk");\n\
Sys.setenv(SPARK_HOME ="/usr/local/spark/");\n\
Sys.setenv(SPARK_HOME_VERSION="2.3.0");\n\
install.packages("sparklyr")' | R

EXPOSE 8787

CMD ["/run.sh"]
