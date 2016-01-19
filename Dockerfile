FROM python:2.7
RUN apt-get update \
    && apt-get install -y \
       enchant \
    && apt-get -q -y clean 

ENV TZ=America/Sao_Paulo
RUN rm -vf /etc/localtime \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime  \
    && echo $TZ > /etc/timezone

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
VOLUME /usr/src/app

ADD assets/myspell.tar.gz /usr/share/enchant/myspell
ADD entrypoint.sh /var/tmp/entrypoint.sh
ADD requirements.txt /usr/src/requirements.txt

RUN pip install -r /usr/src/requirements.txt

ENTRYPOINT ["/var/tmp/entrypoint.sh"]
CMD ["uwsgi", "--ini", "uwsgi.ini"]

