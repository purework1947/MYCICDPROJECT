# Use official Cypress included image
FROM cypress/included:14.5.4

# Set working directory
WORKDIR /app

# Copy package.json and lockfile first (better caching)
COPY package.json package-lock.json ./

# Install dependencies
RUN npm ci --no-audit --no-fund

# Copy rest of the project
COPY . .

# Create allure-results folder
RUN mkdir -p /app/allure-results && chmod -R 777 /app/allure-results

# Environment variables
ENV NO_COLOR=1
ENV FORCE_COLOR=0
ENV CYPRESS_allureResultsPath=/app/allure-results
ENV CYPRESS_allure=true



# Default command (can be overridden by docker run)
CMD ["cypress", "run"]
