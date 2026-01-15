FROM node:20-alpine

ADD .  /app

WORKDIR /app
RUN npm install
EXPOSE 8080
ENTRYPOINT ["npm"]
CMD ["start"]