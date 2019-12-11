#Pull base image
FROM python:3.5.2


# Install Package Libraries
RUN apt-get update && apt-get autoremove && apt-get autoclean
RUN apt-get install -y \
    libffi-dev \
    libssl-dev \
    libmysqlclient-dev \
    libxml2-dev \
    libxslt-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    net-tools \
    vim

RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code/


#-------------------------------------------------------------
# Project Files and Settings
#ARG PROJECT=makeOurPlanetGreatAgain
#ARG PROJECT_DIR=/var/www/${PROJECT}

#Set work directory (Copy your application code to the container)
#RUN mkdir -p $PROJECT_DIR
#WORKDIR $PROJECT_DIR
#ADD . $PROJECT_DIR


#COPY requirements.txt .
#RUN pip install -r requirements.txt

#EXPOSE 8000
#ENTRYPOINT ["python", "manage.py"]
#CMD ["runserver", "0.0.0.0:8000"]


