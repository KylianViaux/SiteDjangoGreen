#Pull base image
FROM python:3.5.2

# Install Package Libraries
RUN apt-get update && apt-get autoremove && apt-get autoclean
RUN apt-get install -y \
    libffi-dev \
    libssl-dev \
    libmysqlclient-dev \
    python3-dev\
    libxml2-dev \
    libxslt-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    net-tools \
    vim

RUN mkdir /mopga
WORKDIR /mopga
ADD ./config/django/requirements.txt /mopga/
RUN pip install -r requirements.txt
ADD ./makeOurPlanetGreatAgain /mopga/

