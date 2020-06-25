FROM python:3
LABEL multi.author="Daniel W" multi.email="github@danieljw.net"

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y apt-utils
RUN apt-get install -y git
# RUN apt install libjpeg-progs optipng

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

CMD ["/bin/bash"]