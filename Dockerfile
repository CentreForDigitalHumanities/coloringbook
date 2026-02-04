FROM ubuntu:20.04

RUN apt-get update

# python 2.7
RUN apt-get install -y python2.7
RUN apt-get install -y python2.7-dev
RUN apt-get install -y curl

# pip 2.7
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
RUN python2.7 get-pip.py

# In order to make SQL work we need the following
RUN apt-get install -y libmysqlclient-dev build-essential
RUN curl https://raw.githubusercontent.com/paulfitz/mysql-connector-c/master/include/my_config.h --output /usr/include/mysql/my_config.h
RUN pip install MySQL-python

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Copy source files
COPY . /coloringbook

# Change working directory
WORKDIR /coloringbook

# Install dependencies
RUN pip install -r requirements.txt --no-cache-dir --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org

# Install Gunicorn for production deployment
RUN pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org gunicorn==19.9.0

# Expose port
EXPOSE 5000
