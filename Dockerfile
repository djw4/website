FROM ipple1986/hexo
MAINTAINER Daniel W &amp;lt;github@danieljw.net&amp;gt;

WORKDIR /opt/hexo/ipple1986
RUN npm install hexo-deployer-ftpsync --save  

CMD ["/usr/bin/hexo", "generate"]
CMD ["/usr/bin/hexo", "serve"]




# ENV HOME /root
# ENV DEBIAN_FRONTEND noninteractive
# RUN yum clean all
# RUN yum update -y -q
# COPY_FROM
# CMD ["python", "app.py"]
# CMD ["/bin/bash"]