FROM ruby:2.4.1

RUN apt-get update && apt-get install -y \
build-essential \
nodejs

WORKDIR /CSV_Maker
