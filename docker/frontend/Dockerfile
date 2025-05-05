# Step 1: Build the React app
FROM node:14.17.0 as build

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the frontend code
COPY . .

# Build React app for production
RUN npm run build

# Step 2: Serve the app with a static web server
FROM node:14.17.0

# Install serve
RUN npm install -g serve

WORKDIR /app

# Copy build files from the previous stage
COPY --from=build /app/build ./build

# Expose the frontend port
EXPOSE 3000

# Run the build with a static server
CMD ["serve", "-s", "build", "-l", "3000"]
