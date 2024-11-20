# Use the official Ubuntu base image
FROM ubuntu:latest

# Set the working directory inside the container
WORKDIR /usr/src/app

# Install curl to download Node.js and install Node.js and npm
RUN apt-get update && apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Clear npm cache before installing dependencies
RUN npm cache clean --force

# Install app dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Expose the port your app runs on
EXPOSE 3000

# Start the Node.js app
CMD [ "npm", "start" ]