FROM cypress/included:14.5.4

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund

COPY . .

RUN mkdir -p /app/allure-results /app/allure-report \
    && chmod -R 777 /app/allure-results /app/allure-report

RUN npm install --save-dev \
    @shelex/cypress-allure-plugin \
    allure-commandline

ENV CYPRESS_allure=true
ENV CYPRESS_allureResultsPath=/app/allure-results
ENV ALLURE_REPORT=/app/allure-report
ENV NO_COLOR=1
ENV FORCE_COLOR=0

CMD sh -c "npx cypress run && npx allure generate /app/allure-results -o /app/allure-report --clean"
