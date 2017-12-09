FROM node:latest

MAINTAINER Yusef Ho <yusef.ho.tw@gmail.com>

COPY ./build/bundle /bundle

RUN cd /bundle/programs/server \
    # && rm -R ./npm/node_modules/meteor/npm-bcrypt && npm install bcrypt \ # for meter version less than 1.6
    && npm install

# If you’re running your Meteor server behind a proxy (so that clients are connecting to the proxy instead of to your server directly), you’ll need to set the HTTP_FORWARDED_COUNT environment variable for the correct IP address to be reported by clientAddress.
# Set HTTP_FORWARDED_COUNT to an integer representing the number of proxies in front of your server. For example, you’d set it to "1" when your server was behind one proxy.
ENV HTTP_FORWARDED_COUNT=1 \
    PORT=80 \
    ROOT_URL=http://localhost.com

# ENV MONGO_URL="mongodb://mongodb:27017/monitoring"

EXPOSE 80

CMD METEOR_SETTINGS=$(cat /bundle/settings.json) && node /bundle/main.js
