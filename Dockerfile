# Use Cypress prebuilt image
FROM cypress/included:12.17.0

WORKDIR /app

# Copy package files first for caching
COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund

# Copy rest of the project
COPY . .

# Default command to run Cypress and generate allure results
CMD ["npx", "cypress", "run"]
