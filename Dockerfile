FROM ipple1986/hexo
LABEL multi.author="Daniel W" multi.email="github@danieljw.net"

#WORKDIR /opt/hexo/ipple1986
RUN ln -s /opt/hexo/ipple1986 /app

WORKDIR /app
RUN npm install hexo-deployer-ftpsync --save  

CMD ["/usr/bin/hexo", "generate", "&&", "/usr/bin/hexo", "serve"]


# ENV HOME /root
# ENV DEBIAN_FRONTEND noninteractive
# RUN yum clean all
# RUN yum update -y -q
# COPY_FROM
# CMD ["python", "app.py"]
# CMD ["/bin/bash"]