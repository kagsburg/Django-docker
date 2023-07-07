

FROM python:3.8-alpine

ENV PATH="/scripts:${PATH}"

COPY ./requirements.txt /requirements.txt
# Required alpine packages to instal uwsgi
RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers
RUN pip install -r /requirements.txt
# remove the temporary packages
RUN apk del .tmp

RUN mkdir /app

COPY ./app /app
# change the working directory to /app
WORKDIR /app

COPY ./scripts /scripts

RUN chmod +x /scripts/*
# for the static files

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static

RUN adduser -D user1

RUN chown -R user1:user1 /vol/
RUN chmod -R 755 /vol/web

USER user1

CMD ["entrypoint.sh"]
