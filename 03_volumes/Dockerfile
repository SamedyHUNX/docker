FROM node:14

ARG DEFAULT_PORT = 80

WORKDIR /app

COPY package.json /app

RUN npm install

COPY . .

ENV PORT $DEFAULT_PORT

EXPOSE $PORT

# Volume
# VOLUME ["/app/feedback"]

CMD ["npm", "start"]