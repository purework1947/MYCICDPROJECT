FROM cypress/included:12.17.0

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .

# run tests + generate report
CMD sh -c "npx cypress run && npx allure generate allure-results --clean -o allure-report"
