FROM cypress/included:14.5.4

# 🔥 override Cypress entrypoint
ENTRYPOINT []

WORKDIR /app

# ✅ Install Java (Allure requirement)
RUN apt-get update && \
    apt-get install -y default-jre-headless && \
    apt-get clean

# Optional (Allure does not strictly need JAVA_HOME, but good practice)
ENV JAVA_HOME=/usr/lib/jvm/default-java
ENV PATH=$JAVA_HOME/bin:$PATH

COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund

COPY . .

RUN mkdir -p allure-results allure-report \
    && chmod -R 777 allure-results allure-report

ENV NO_COLOR=1
ENV FORCE_COLOR=0

CMD ["sh", "-c", "npx cypress run --spec cypress/e2e/1-getting-started/todo.cy.js && npx allure generate allure-results --clean -o allure-report"]
