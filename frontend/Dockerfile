FROM current-bookworm-slim

# Set the working directory in the container
WORKDIR /app

# Copy package.json and yarn.lock
COPY package.json yarn.lock /app/

# Install dependencies
RUN yarn install

# Copy the current directory contents into the container at /app
COPY --from=dist dist/ /app/

# Expose port 5173 to access the server
EXPOSE 5173

# Command to run the application
CMD ["yarn", "dev", "--host", "0.0.0.0"]
