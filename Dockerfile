# Use official Cypress included image
FROM cypress/included:14.5.4

# Set working directory
WORKDIR /app

# Copy package.json and lockfile first for caching
COPY package.json package-lock.json ./

# Install node modules
RUN npm ci --no-audit --no-fund

# Copy rest of the project
COPY . .

# Create allure-results folder with full permissions
RUN mkdir -p /app/allure-results && chmod -R 777 /app/allure-results

# Set environment variable for Allure
ENV NO_COLOR=1
ENV FORCE_COLOR=0
ENV CYPRESS_allureResultsPath=/app/allure-results

# Default command to run Cypress tests
CMD ["cypress", "run"]
