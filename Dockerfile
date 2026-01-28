# Cypress official image with browsers + node
FROM cypress/included:12.17.0

# Set working directory
WORKDIR /app

# Copy dependency files first (better cache)
COPY package.json package-lock.json ./

# Install dependencies
RUN npm ci

# Copy rest of project
COPY . .

# Run Cypress tests (headless)
CMD ["npx", "cypress", "run"]
