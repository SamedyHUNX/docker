# 1. Run "node" image (either locally or from cloud)
FROM node

# 2. Copy (first dot specifies to copy everything to the image)
# (second dot specifies the location to be copied to /)
# WORKDIR tells docker where the subsequent commands happens
WORKDIR /app
COPY package.json /app

# 3. Command(s) to be executed
RUN npm install

COPY . /app

EXPOSE 80

# 4. RUN the server
# CMD specifies that it should be executed in container
CMD ["node", "server.js"]
