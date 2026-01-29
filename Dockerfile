FROM cypress/included:12.17.0

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund

COPY . .

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["npx cypress run && npx allure generate allure-results --clean -o allure-report"]
