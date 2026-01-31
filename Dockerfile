FROM cypress/included:14.5.4

# 🔥 override Cypress entrypoint
ENTRYPOINT []

WORKDIR /app

# Install Java (Allure requirement)
RUN apt-get update && \
    apt-get install -y default-jre-headless && \
    apt-get clean

ENV JAVA_HOME=/usr/lib/jvm/default-java
ENV PATH=$JAVA_HOME/bin:$PATH

# Install node dependencies
COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund

# Copy project
COPY . .

# Create folders for Allure results & report
RUN mkdir -p allure-results allure-report && chmod -R 777 allure-results allure-report

# Environment variables for Cypress
ENV NO_COLOR=1
ENV FORCE_COLOR=0
ENV CYPRESS_allure=true
ENV CYPRESS_allureResultsPath=/app/allure-results
ENV ALLURE_REPORT=/app/allure-report
