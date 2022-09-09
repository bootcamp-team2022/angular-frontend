# your code goes here ...
FROM python:3.9-slim

ENV CONTAINER_HOME=/var/www

RUN mkdir $CONTAINER_HOME

ADD . $CONTAINER_HOME

WORKDIR $CONTAINER_HOME


RUN pip install -r ${CONTAINER_HOME}/requirements.txt

