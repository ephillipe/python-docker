FROM python:2.7.15-stretch
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       enchant cron unixodbc unixodbc-dev openssl locales-all \
    && pip install --upgrade pip \
    && apt-get -q -y clean 

ENV TZ=America/Sao_Paulo
RUN rm -vf /etc/localtime \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime  \
    && echo $TZ > /etc/timezone

RUN mkdir -p /usr/src/app \
    && touch /usr/src/app/readme
WORKDIR /usr/src/app
VOLUME /usr/src/app

ADD assets/myspell.tar.gz /usr/share/enchant/myspell
ADD entrypoint.sh /var/tmp/entrypoint.sh

RUN curl -q -L https://raw.github.com/kvz/cronlock/master/cronlock -o /usr/bin/cronlock \
	&& chmod +x /usr/bin/cronlock
	
ADD requirements.txt /usr/src/app/requirements.txt	
RUN pip install -r /usr/src/app/requirements.txt	

ENTRYPOINT ["/var/tmp/entrypoint.sh"]
CMD ["uwsgi", "--ini", "uwsgi.ini"]
