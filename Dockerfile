FROM python:3
LABEL multi.author="Daniel W" multi.email="github@danieljw.net"

WORKDIR /usr/src/app

RUN apt update
RUN apt install git
# RUN apt install libjpeg-progs optipng

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# COPY . .

# CMD [ "python", "./your-daemon-or-script.py" ]
CMD ["/bin/bash"]