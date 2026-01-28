# Use Cypress pre-installed image
FROM cypress/included:12.17.0

WORKDIR /app

# Copy package.json & package-lock.json and install dependencies
COPY package.json package-lock.json ./
RUN npm ci

# Copy all project files
COPY . .

# Default command: run Cypress headless
CMD ["npx", "cypress", "run"]
