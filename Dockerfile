FROM ipple1986/hexo
MAINTAINER Daniel W &amp;lt;dw@danieljw.net&amp;gt;

#ENV HOME /root
#ENV DEBIAN_FRONTEND noninteractive

#RUN yum clean all
#RUN yum update -y -q

WORKDIR /opt/hexo/ipple1986
RUN npm install hexo-deployer-ftpsync --save
  
#COPY_FROM

#CMD ["python", "app.py"]
CMD ["/bin/bash"]