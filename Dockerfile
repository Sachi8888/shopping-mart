FROM node:21-alpine

# Create app directory and set ownership to 'node' user
RUN mkdir -p /home/node/app && chown -R node:node /home/node/app

# Set the working directory
WORKDIR /home/node/app

# Copy package files first to leverage Docker cache for dependencies
COPY --chown=node:node package*.json ./

# Switch to 'node' user before running npm install
USER node

# Install dependencies
RUN npm install

# Copy remaining files (including 'package-lock.json' and app files) with correct ownership
COPY --chown=node:node . .

# Expose port
EXPOSE 3000

# Run the application
CMD ["node", "app.js"]
